require 'test_plugin_helper'

class DiscoveredMailerTest < ActiveSupport::TestCase
  setup do
    @user = User.current = users :admin

    FactoryGirl.create(:mail_notification,
                       :name => :discovered_summary,
                       :description => N_('A summary of discovered hosts'),
                       :mailer => 'DiscoveredMailer',
                       :method => 'discovered_summary',
                       :subscription_type => 'report',
    )

    @user.mail_notifications << MailNotification[:discovered_summary]

    ActionMailer::Base.deliveries = []
    @user.user_mail_notifications.first.deliver
    @email = ActionMailer::Base.deliveries.first
  end

  test 'discovery mailer should deliver summary' do
    assert @email.to.include?("admin@someware.com")
  end

  test 'discovery mailer should contain body' do
    refute @email.body.nil?
  end

  test 'discovery mailer should have a correct subject' do
    refute @email.subject.empty?
    assert @email.subject.include? Setting[:email_subject_prefix].first
  end

  test 'discovery mailer sends Foreman URL in body' do
    assert @email.body.parts.first.body.raw_source.include? Setting[:foreman_url]
  end

  test 'discovery mailer sends both html and text emails' do
    assert_equal(2, @email.body.parts.size)
    refute(@email.body.parts.first.body.raw_source.start_with?('<!DOCTYPE')) # text email
    assert(@email.body.parts.last.body.raw_source.start_with?('<!DOCTYPE')) # html email
  end
end
