require 'test_helper'

class InterestTest < ActiveSupport::TestCase

  fixtures :all

  def test_smoke
    u = User.create! email: 'joe@bloggs.com', password: 'bloggsamatic!'
    t = Topic.first
    Interest.create! user: u, topic: t
    assert_equal [t], u.topics.to_a
  end
end
