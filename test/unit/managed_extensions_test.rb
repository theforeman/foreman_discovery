require_relative '../test_plugin_helper'

class ManagedExtensionsTest < ActiveSupport::TestCase
  class StubHost < ApplicationRecord
    include Host::ManagedExtensions

    # prevent from Could not find table exception
    def self.table_name
      'hosts'
    end
  end

  let(:kexec_template) { FactoryBot.build(:provisioning_template, :template => File.read(File.expand_path(File.join("..", "..", "..", "app", "views", "foreman_discovery", "redhat_kexec.erb"), __FILE__))) }

  context "stubbed orchestration" do
    setup do
      set_default_settings

      @host = StubHost.new
      @host.type = "Host::Discovered"
      @host.stubs(:old).returns(@host)
      @facts = {}
      @host.stubs(:facts).returns(@facts)
      @post_queue = mock('Post Queue')
      @host.stubs(:post_queue).returns(@post_queue)
      @operatingsystem = mock('OS')
      @operatingsystem.stubs(:additional_media).returns({})
      @host.stubs(:operatingsystem).returns(@operatingsystem)
      @host.stubs(:provisioning_template).returns(kexec_template)
      @host.stubs(:medium).returns('http://a_medium')
      @host.stubs(:architecture).returns(FactoryBot.create(:architecture))
      ::MediumProviders::Default.any_instance.stubs(:validate).returns([])
    end

    test "queue_reboot enques reboot command when there is no kexec fact" do
      @host.stubs(:will_save_change_to_attribute?).with(:type, from: 'Host::Discovered').returns(true)
      @host.stubs(:new_record?).returns(false)
      @host.id = 130513
      @post_queue.expects(:create).with(has_entry(:action, [@host, :setReboot])).once
      @host.queue_reboot
    end

    test "queue_reboot enques reboot command when there is no kexec template" do
      @host.stubs(:will_save_change_to_attribute?).with(:type, from: 'Host::Discovered').returns(true)
      @host.stubs(:new_record?).returns(false)
      @host.id = 130513
      @facts['discovery_kexec'] = "Kexec version X.Y.Z"
      @host.stubs(:provisioning_template).returns(nil)
      @post_queue.expects(:create).with(has_entry(:action, [@host, :setReboot])).once
      @host.queue_reboot
    end

    test "queue_reboot enques kexec command" do
      @host.stubs(:will_save_change_to_attribute?).with(:type, from: 'Host::Discovered').returns(true)
      @host.stubs(:new_record?).returns(false)
      @host.id = 130513
      @facts['discovery_kexec'] = "Kexec version X.Y.Z"
      @post_queue.expects(:create).with(has_entry(:action, [@host, :setKexec])).once
      @host.queue_reboot
    end

    test "setReboot calls reboot API" do
      Host::Discovered.any_instance.expects(:reboot).once
      @host.setReboot
    end

    test "setKexec calls renderer" do
      Host::Discovered.any_instance.expects(:render_template).with() { |json| JSON.parse(json) }.once
      Foreman::Renderer.expects(:render).returns({})
      @host.setKexec
    end
  end

  context "host" do
    setup do
      set_default_settings
      interface = FactoryBot.build(:nic_primary_and_provision, identifier: 'eth0', mac: '00-f0-54-1a-7e-e0', ip: '127.0.0.1')
      domain = FactoryBot.build(:domain, name: 'snapshotdomain.com')
      subnet = FactoryBot.build(:subnet_ipv4, name: 'one', network: interface.ip)
      architecture = Architecture.find_by_name('x86_64')
      medium = FactoryBot.create(:medium, name: 'CentOS mirror')
      ptable = FactoryBot.create(:ptable, name: 'ptable')
      @operatingsystem = FactoryBot.create(:operatingsystem, name: 'Redhat', major: 7, architectures: [architecture], media: [medium], ptables: [ptable]).becomes(::Redhat)
      @host = FactoryBot.build(:host, :managed, hostname: 'snapshothost', domain: domain, subnet: subnet, architecture: architecture, medium: medium,
        ptable: ptable, operatingsystem: @operatingsystem, interfaces: [interface])
      @host.stubs(:provisioning_template).returns(kexec_template)
    end

    test "kexec template is correctly rendered" do
      expected = {
        "append" => "ks=http://foreman.some.host.fqdn/unattended/provision&static=yes inst.ks.sendmac ip=::::::none nameserver= ksdevice=bootif BOOTIF= nomodeset nokaslr nomodeset",
        "extra" => []
      }
      assert @host.operatingsystem.respond_to?(:pxe_type)
      assert @host.medium_provider
      result = @host.render_kexec_template
      assert_match(/http:\/\/www.example.com.*vmlinuz/, result.delete("kernel"))
      assert_match(/http:\/\/www.example.com.*initrd.img/, result.delete("initram"))
      assert_equal expected, result
    end
  end
end
