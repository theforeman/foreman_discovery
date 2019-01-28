require_relative '../test_plugin_helper'

class ManagedExtensionsTest < ActiveSupport::TestCase
  class StubHost < ApplicationRecord
    include Host::ManagedExtensions

    # prevent from Could not find table exception
    def self.table_name
      'hosts'
    end
  end

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
    @host.stubs(:operatingsystem).returns(@operatingsystem)
    @host.stubs(:provisioning_template).returns('A template')
    @host.stubs(:medium).returns('http://a_medium')
    @host.stubs(:architecture).returns(FactoryBot.create(:architecture))
    @kexec_json = {
      :kernel => "http://a_host/vmlinuz",
      :initrd => "http://a_host/someimage.img"
    }
    @host.stubs(:unattended_render).returns(@kexec_json.to_json)
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
end
