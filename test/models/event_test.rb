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

end
