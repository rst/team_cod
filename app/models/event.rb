class Event < ActiveRecord::Base

  has_many :event_topics
  has_many :topics, through: :event_topics

  validates :name, length: {minimum: 1, maximum: 200}
  validates :starts_at, presence: true
end
