class ListingsMailer < ApplicationMailer

  def user_weekly_email(user)
    @user = user
    @listings = 
       user.events_of_interest
           .where_current
           .order("created_at desc")
           .includes(:topics)
    
    mail(to: @user.email, subject: 'Job listings from YouthHub')
  end

  def self.weekly_send_job
    users = User.includes(:topics)
    users.each do |user|
      self.user_weekly_email(user).deliver_now
    end
  end

end
