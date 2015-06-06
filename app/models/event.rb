class Event < ActiveRecord::Base
  validates :name, length: {minimum: 1, maximum: 200}
  validates :starts_at, presence: true
end
