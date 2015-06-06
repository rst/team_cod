class Event < ActiveRecord::Base

  has_many :event_topics
  has_many :topics, through: :event_topics

  validates :name, length: {minimum: 1, maximum: 200}
  validates :starts_at, presence: true

  def self.for_topics(topics)
    if topics.empty?
      self.none
    else
      self.joins(:event_topics).where("event_topics.topic_id in (?)", 
                                      topics.collect(&:id))
    end
  end
end
