class RegenerateRedHatKexec < ActiveRecord::Migration
  def up
    t = ProvisioningTemplate.find_by_name("Discovery Red Hat kexec")
    t.update_attributes(:template => t.template.sub(/rescue ''$/, 'if mac')) if t
  end

  def down
    # rollback is not supported
  end
end
