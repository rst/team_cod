require 'test_helper'

class EventTest < ActiveSupport::TestCase

  fixtures :all

  def test_smoke_event_topics
    ev = events(:cyber_jamboree)
    t = topics(:retail)

    assert_equal [], ev.topics.to_a

    EventTopic.create! event: ev, topic: t
    assert_equal [t], ev.topics(:reload).to_a
  end

  def test_validations
    ev = Event.new
    do_test_validation ev, :name, invalid: ['', 'x'*1000], valid: ['foo']
    do_test_validation ev, :expires_in_days,
      invalid: ['x', '3x', '2.5', 'three'],
      valid: [nil, '', '-1', '0', '5', '500']
    assert ev.valid?
  end

  def test_has_topic_named
    ev = events(:cyber_jamboree)
    assert !ev.has_topic_named?('Programming')

    ev.topics << topics(:programming)
    assert ev.has_topic_named?('Programming')
  end

  def test_set_expires_in_days
    ev = Event.new
    ev.expires_in_days = 1

    # Time equality operators are myteriously finicky in Rails 4.2, hence
    # the ".to_s" nonsense...

    assert_equal Time.zone.now.at_end_of_day.to_s, ev.expires_at.to_s
    ev.expires_in_days = 2
    assert_equal (Time.zone.now + 1.day).at_end_of_day.to_s, ev.expires_at.to_s
    ev.expires_in_days = 3
    assert_equal (Time.zone.now + 2.days).at_end_of_day.to_s, ev.expires_at.to_s
    ev.expires_in_days = 0
    assert_equal (Time.zone.now - 1.day).at_end_of_day.to_s, ev.expires_at.to_s
  end

  def test_compute_expires_in_days
    ev = Event.new
    ev.expires_at = Time.zone.now.at_end_of_day
    assert_equal 1, ev.expires_in_days
    ev.expires_at = 2.days.from_now.at_end_of_day
    assert_equal 3, ev.expires_in_days
    ev.expires_at = 1.day.ago.at_end_of_day
    assert_equal 0, ev.expires_in_days
    ev.expires_at = 2.days.ago.at_end_of_day
    assert_equal -1, ev.expires_in_days
  end

  def test_expiry_scopes_and_sorts

    # Start with a clean tbl...

    Event.all.each { |ev| ev.destroy }

    # Create some events

    expired   = Event.create! name: "expired",   expires_in_days: -1
    expiredd  = Event.create! name: "expiredd",  expires_in_days: -10
    expiring  = Event.create! name: "expiring",  expires_in_days: 1
    current   = Event.create! name: "current",   expires_in_days: 7
    continual = Event.create! name: "continual", expires_in_days: nil

    # Verify that our stock scopes and orderings do right with these...

    assert_equal [expiring, current, continual],
      Event.where_current.order_expiring_first.to_a

    assert_equal [expired, expiredd],
      Event.where_expired.order_recently_expired_first.to_a
    
  end

  def test_event_for_topics

    assert_equal [], Event.for_topics([])

    programming = topics(:programming)
    retail = topics(:retail)
    cyberj = events(:cyber_jamboree)

    EventTopic.create! event: cyberj, topic: programming
    assert_equal [cyberj], Event.for_topics([programming])
    assert_equal [cyberj], Event.for_topics([programming, retail])

    ev2 = Event.create! name: "sales training", starts_at: 2.days.from_now
    EventTopic.create! event: ev2, topic: topics(:retail)

    assert_equal [cyberj, ev2], 
                 Event.for_topics([programming, retail]).order("starts_at")

  end

  def test_event_requiring_topic

    retail = topics(:retail)
    prog = topics(:programming)
    cy = events(:cyber_jamboree)

    assert_equal [], Event.requiring_topic(retail).requiring_topic(prog).to_a
    assert_equal [], Event.requiring_topics([retail, prog]).to_a

    cy.topics << retail

    assert_equal [cy], Event.requiring_topic(retail).to_a
    assert_equal [], Event.requiring_topics([retail, prog]).to_a

    cy.topics << prog

    assert_equal [cy], Event.requiring_topic(retail).requiring_topic(prog).to_a
    assert_equal [cy], Event.requiring_topics([retail, prog]).to_a

  end

end
