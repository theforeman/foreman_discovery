require_relative '../test_plugin_helper'
require 'integration_test_helper'

class DiscoveredHostsTest < IntegrationTestWithJavascript
  let(:discovered_host) { FactoryBot.create(:discovered_host, :with_facts) }
  let(:subnet) { FactoryBot.create(:subnet_ipv4, :network => "192.168.100.0") }
  let(:discovered_hosts) { Host::Discovered.all }

  setup do
    assert discovered_notification_blueprint
    discovered_host.save!
    visit discovered_hosts_path
    page.evaluate_script("document.getElementById('fixedPropertiesSelector-#{discovered_host.id}').classList.remove('fade')")
    ::ForemanDiscovery::HostConverter.stubs(:unused_ip_for_host)
  end

  teardown do
    Host::Discovered.destroy_all
  end

  describe 'Perform host Reboot' do
    test 'triggers reboot on a single discovered_host' do
      Host::Discovered.any_instance.stubs(:subnet).returns(subnet)
      Host::Discovered.any_instance
                      .expects(:reboot)
                      .at_least(discovered_hosts.count)
      select_host_checkbox(discovered_host.id)
      page.find_link('Select Action').click
      page.find_link('Reboot').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
    end

    test 'triggers reboot on all discovered_hosts' do
      Host::Discovered.any_instance.stubs(:subnet).returns(subnet)
      Host::Discovered.any_instance
                      .expects(:reboot)
                      .at_least(discovered_hosts.count)
      select_all_hosts
      page.find_link('Select Action').click
      page.find_link('Reboot').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
    end

    test 'shows warning for all hosts with missing subnet' do
      select_all_hosts
      page.find_link('Select Action').click
      page.find_link('Auto Provision').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
      wait_for_ajax
      assert page.has_text?("Discovered hosts reported from unknown subnet")
    end
  end

  describe 'Perform host Autoprovision' do
    test 'converts single discovered to managed host' do
      Host::Discovered.any_instance.stubs(:subnet).returns(subnet)
      select_host_checkbox(discovered_host.id)
      page.find_link('Select Action').click
      page.find_link('Auto Provision').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
    end

    test 'converts all discovered to managed hosts' do
      Host::Discovered.any_instance.stubs(:subnet).returns(subnet)
      select_all_hosts
      page.find_link('Select Action').click
      page.find_link('Auto Provision').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
      wait_for_ajax
      assert page.has_text?('Discovered hosts are provisioning now')
    end

    test 'shows warning for all hosts with missing subnet' do
      select_all_hosts
      page.find_link('Select Action').click
      page.find_link('Auto Provision').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
      wait_for_ajax
      assert page.has_text?("Discovered hosts reported from unknown subnet")
    end
  end

  describe 'Delete hosts' do
    test 'it removes all hosts' do
      select_all_hosts
      page.find_link('Select Action').click
      page.find_link('Delete').click
      wait_for_ajax
      assert page.has_text?('The following hosts are about to be changed')
      page.find_button('Submit').click
      wait_for_ajax
      assert page.has_text?('Destroyed selected hosts')
    end
  end

  describe 'using Create Host link' do
    setup do
      page.find("#host_ids_#{discovered_host.id}")
          .query_scope
          .find_link('Provision').click
    end

    test 'and forwards to editing it' do
      create_host
      assert_current_path edit_discovered_host_path(id: discovered_host), ignore_query: true
    end

    context 'with a Hostgroup selected' do
      let(:discovery_hostgroup) { Hostgroup.first }

      test 'it passes it on' do
        select2(discovery_hostgroup.name, from: 'host_hostgroup_id')
        create_host
        assert_param discovery_hostgroup.id.to_s,
                     'host.hostgroup_id'
      end
    end

    context 'with a Location selected' do
      let(:discovery_location) { Location.first }

      test 'it passes it on' do
        select2(discovery_location.name, from: 'host_location_id')
        create_host
        assert_param discovery_location.id.to_s,
                     'host.location_id'
      end
    end

    context 'with a Organization selected' do
      let(:discovery_organization) { Organization.first }

      test 'it passes it on' do
        select2(discovery_organization.name, from: 'host_organization_id')
        create_host
        assert_param discovery_organization.id.to_s,
                     'host.organization_id'
      end
    end
  end

  describe 'edit form' do
    test 'it is a host form' do
      visit edit_discovered_host_path(discovered_host)
      assert page.find("form#edit_host_#{discovered_host.id}")
    end

    context 'with a hostgroup passed' do
      let(:hostgroup_environment) { FactoryBot.create(:environment) }
      let(:hostgroup_domain) { FactoryBot.create(:domain) }
      let(:hostgroup) do
        FactoryBot.create(:hostgroup, :with_os,
                           environment: hostgroup_environment,
                           domain: hostgroup_domain)
      end

      setup do
        visit edit_discovered_host_path(discovered_host,
                                        'host[hostgroup_id]' => hostgroup.id)
        page.find("a[href='#os']").click
        assert_selected '#host_hostgroup_id', hostgroup.id
      end

      it 'sets inherited attributes' do
        %i[environment architecture operatingsystem].each do |attribute|
          assert_selected "#host_#{attribute}_id", hostgroup.send(attribute).id
        end

        page.find('a[href="#network"]').click
        page.find_button('Edit').click
        assert_selected '#host_interfaces_attributes_0_domain_id',
                        hostgroup.domain.id
      end
    end
  end

  private

  def select_all_hosts
    page.find('#check_all').click
  end

  def select_host_checkbox(id)
    page.find("#host_ids_#{id}").click
  end

  def create_host
    page.find("#fixedPropertiesSelector-#{discovered_host.id}")
        .find_button('Create Host').click
    wait_for_ajax
  end
end
