class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :interests
  has_many :topics, through: :interests

  def events_of_interest
    Event.joins("join event_topics et on et.event_id = events.id")
         .joins("join interests int on et.topic_id = int.topic_id")
         .where("int.user_id = ?", self.id)
  end
end
