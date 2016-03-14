class Event < ActiveRecord::Base

  has_many :event_topics
  has_many :topics, through: :event_topics

  validates :name, length: {minimum: 1, maximum: 200}

  ################################################################
  # Instance stuff...

  # quick check for specific topics

  def has_topic_named?(name)
    topics.collect(&:name).include?(name)
  end

  # Pseudo-attribute which backs "expires in X days" in UI.
  #
  # The rule is that if expires_in_days is 1, then expires_at is
  # DateTime.today.at_end_of_day.  If it's a different integer, then
  # the value is adjusted from there by calendar days as one would
  # expect.  See tests...

  validates :expires_in_days, numericality: {
    only_integer: true, 
    allow_blank: true}

  def expires_at=(value)
    write_attribute(:expires_at, value)
    @expires_in_days = nil      # force recomputation, if desired...
  end

  def expires_in_days
    @expires_in_days ||= 
      if expires_at.blank?
        nil
      else
        (((expires_at - Time.zone.now) / (24*60*60)).floor + 1)
      end
  end

  def expires_in_days=(value)
    if value.blank?
      self.expires_at = nil
    else
      ndays = value.to_i - 1
      self.expires_at = (DateTime.now.in_time_zone + ndays.days).at_end_of_day
    end
    @expires_in_days = value
  end

  ################################################################
  # Queries, scopes, etc.

  def self.where_current
    # The coalesce replaces a null "expires_at" with now(), so the >= succeeds.
    self.where("coalesce(expires_at, now()) >= now()")
  end

  def self.where_expired
    self.where("expires_at < now()")
  end

  def self.order_expiring_first
    self.order("expires_at asc nulls last")
  end

  def self.order_recently_expired_first
    self.order("expires_at desc")
  end

  def self.for_topics(topics)

    return self.none if topics.empty?

    topic_groups = topics.group_by(&:topic_group).values

    topic_groups.inject(self.all) do |scope, group|
      scope.for_any_of_topics(group)
    end

  end

  def self.for_any_of_topics(topics)
    if topics.empty?
      self.none
    else
      join_name = "topic_#{topics.first.id.to_i}"
      self.joins("join event_topics as #{join_name} on #{join_name}.event_id = events.id")
          .where("#{join_name}.topic_id in (?)", topics.collect(&:id))
    end
  end

  def self.requiring_topic(topic)
    join_name = "topic_#{topic.id.to_i}"
    self.joins("join event_topics as #{join_name} on #{join_name}.event_id = events.id")
      .where("#{join_name}.topic_id = ?", topic.id)
  end

  def self.requiring_topics(topics)
    query = self.all
    topics.each do |topic|
      query = query.requiring_topic(topic)
    end
    query
  end

end
