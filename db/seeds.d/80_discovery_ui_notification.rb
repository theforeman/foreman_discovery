# seeds UI notification blueprints that are supported by Disocvery.
[
  {
    group: _('New hosts'),
    name: 'new_discovered_host',
    message: _('One or more hosts have been discovered'),
    level: 'info',
    actions:
    {
      links:
      [
        path_method: :discovered_hosts_path,
        title: _('Details'),
      ],
    },
  },
  {
    group: _('Hosts'),
    name: 'failed_discovery',
    message: _('Error message goes here'),
    level: 'error',
  },
].each { |blueprint| UINotifications::Seed.new(blueprint).configure }
