# set discovery search attributes first
module ForemanDiscovery
  module ImportHooks
    class DiscoveryAttribute < ImportHook
      def after_populate
        # This should be done in a SQL transaction but we cannot use transactions for
        # host updates because it utterly breaks our orchestration. We must work with
        # the fact that discovery_attribute_set can end up being nil and controllers
        # and views must be aware and render zero/blank values.
        if host.discovery_attribute_set
          host.discovery_attribute_set.update(import_from_facts)
        else
          host.build_discovery_attribute_set(import_from_facts)
        end
      end

      def import_from_facts
        cpu_count  = facts['physicalprocessorcount'].to_i rescue 0
        memory     = facts['memorysize_mb'].to_f.ceil rescue 0
        disks      = facts.select { |key, value| key.to_s =~ /blockdevice.*_size/ }
        disks_size = 0
        disk_count = 0

        if disks.any?
          disks.values.each { |size| disks_size += (size.to_f rescue 0) }
          disk_count = disks.size
          # Turning disks_size to closest Mega for easier to read UI
          disks_size = (disks_size / 1024 / 1024).ceil if disks_size > 0
        end

        {
          cpu_count: cpu_count,
          memory: memory,
          disk_count: disk_count,
          disks_size: disks_size
        }
      end
    end
  end
end
