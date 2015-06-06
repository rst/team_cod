require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def test_validations
    old_topic = topics(:retail)
    assert !Topic.new(name: old_topic.name).valid? # uniqueness
    assert Topic.new(name: 'x' + old_topic.name).valid?
    assert !Topic.new.valid?    # no name
    assert !Topic.new(name: '').valid?
    assert !Topic.new(name: 'x'*100).valid?
  end
end
