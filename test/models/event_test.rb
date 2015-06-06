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

end
