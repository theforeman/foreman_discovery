require_relative '../test_plugin_helper'

class DiscoveredMailerTest < ActiveSupport::TestCase
  include FactImporterIsolation
  allow_transactions_for_any_importer

  setup do
    set_default_settings
    @user = User.current = users :admin
    facts = parse_json_fixture('regular_host', true)
    @host = discover_host_from_facts(facts)

    FactoryBot.create(:mail_notification,
                       :name => :discovered_summary,
                       :description => N_('A summary of discovered hosts'),
                       :mailer => 'DiscoveredMailer',
                       :method => 'discovered_summary',
                       :subscription_type => 'report'
    )

    @user.mail_notifications << MailNotification[:discovered_summary]

    ActionMailer::Base.deliveries = []
    @user.user_mail_notifications.first.deliver
    @email = ActionMailer::Base.deliveries.first
  end

  test 'discovery mailer should deliver summary' do
    assert @email.to.include?("admin@someware.com")
  end

  test 'discovery mailer should contain body and two parts' do
    assert_not @email.body.nil?
    assert_equal 2, @email.body.parts.size
  end

  test 'discovery mailer should have a correct subject' do
    assert_not @email.subject.empty?
    assert @email.subject.include? Setting[:email_subject_prefix].first
  end

  test 'discovery mailer sends link to the discovered host in body' do
    assert @email.body.parts.first.body.raw_source.include? "#{Setting[:foreman_url]}/discovered_hosts/#{@host.name}"
    assert @email.body.parts.last.body.raw_source.include? "#{Setting[:foreman_url]}/discovered_hosts/#{@host.name}"
  end

  test 'discovery mailer sends both html and text emails' do
    assert_equal(2, @email.body.parts.size)
    assert_not(@email.body.parts.first.body.raw_source.start_with?('<!DOCTYPE')) # text email
    assert(@email.body.parts.last.body.raw_source.start_with?('<!DOCTYPE')) # html email
  end

  test 'discovery mailer sends email when user object is used' do
    assert MailNotification[:discovered_summary].deliver(user: @user)
  end

  test 'discovery mailer sends email when user id is used' do
    assert MailNotification[:discovered_summary].deliver(user: @user.id)
  end

  test 'discovery mailer must raise exception when sending email to an unknown user type' do
    assert_raises Foreman::Exception do
      MailNotification[:discovered_summary].deliver(user: @user.mail)
    end
  end
end
