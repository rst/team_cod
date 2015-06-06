require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :all

  def test_smoke_events_of_interest

    u = users(:lucy)
    assert_equal [], u.events_of_interest.to_a

    cyberj = events(:cyber_jamboree)
    programming = topics(:programming)

    Interest.create! user: u, topic: programming
    EventTopic.create! event: cyberj, topic: programming

    u.topics(:reload)           # clear memoization
    assert_equal [cyberj], u.events_of_interest.to_a

  end

end
