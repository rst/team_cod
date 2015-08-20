require 'test_helper'

class ListingsMailerTest < ActionMailer::TestCase

  def test_user_weekly_email_empty
    u = users(:lucy)
    assert u.events_of_interest.empty?
    mail = ListingsMailer.user_weekly_email(u).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_match /didn\'t find any this week/, mail.body.to_s
  end

  def test_user_weekly_email_nonempty
    u = users(:lucy)
    cyberj = events(:cyber_jamboree)
    programming = topics(:programming)

    Interest.create! user: u, topic: programming
    EventTopic.create! event: cyberj, topic: programming

    assert_not u.events_of_interest.empty?

    mail = ListingsMailer.user_weekly_email(u).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?
    assert_match /#{Regexp.quote(cyberj.name)}/, mail.body.to_s
  end

end
