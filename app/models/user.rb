class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :interests
  has_many :topics, through: :interests

  def events_of_interest
    Event.for_topics(self.topics.to_a)
  end

  def self.create_with_random_password!(opts)

    # Validations won't allow us to create with *no* password, which
    # would otherwise be desirable for "fake registrations" (create
    # thru console or by authorized admin, then go thru recovery to
    # assign password).  So, generate a strong random pw, and throw
    # it away...

    pw = File.open('/dev/urandom', 'r') do |f|
      Base64.encode64(f.read(10)).chomp
    end

    self.create!(opts.merge(password: pw))

  end

end
