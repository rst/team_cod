ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def do_test_validation(obj, attr, valid:, invalid:)
    setter = attr.to_s + '='

    invalid.each do |val|
      obj.send setter, val
      obj.valid?
      assert_not_empty obj.errors[attr], "#{val.inspect} valid for #{attr}"
    end

    valid.each do |val|
      obj.send setter, val
      obj.valid?
      assert_empty obj.errors[attr], "#{val.inspect} invalid for #{attr}"
    end
  end
end
