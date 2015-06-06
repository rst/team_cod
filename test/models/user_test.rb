require 'test_helper'

class UserTest < ActiveSupport::TestCase

  fixtures :all

  def test_smoke_events_of_interest
    u = users(:lucy)
    assert_equal [], u.events_of_interest.to_a

    cyberj = events(:cyber_jamboree)
    retail = topics(:retail)

    Interest.create! user: u, topic: retail
    EventTopic.create! event: cyberj, topic: retail

    assert_equal [cyberj], u.events_of_interest.to_a
  end

end
