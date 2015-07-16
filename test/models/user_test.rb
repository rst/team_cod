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

  def test_create_with_random_pw
    # Hard to explicitly test the "random, throwaway password" part,
    # but we can do this...

    user = User.create_with_random_password! email: 'boho@bobo.com'
    assert user.is_a?(User)
    assert !user.new_record?
    assert_equal 'boho@bobo.com', user.email
  end

end
