class Topic < ActiveRecord::Base
  validates :name, uniqueness: true, length: {minimum: 1, maximum: 99}
end
