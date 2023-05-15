 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['en'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "foreman-dev@googlegroups.com",
        "PO-Revision-Date": "2015-12-27 01:18+0000",
        "Last-Translator": "",
        "Language-Team": "EnglishMIME-Version: 1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "en",
        "Plural-Forms": "nplurals=2; plural=(n != 1);",
        "lang": "en",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=2; plural=(n != 1);"
      },
      "List all discovered hosts": [
        ""
      ],
      "filter results": [
        ""
      ],
      "sort results": [
        ""
      ],
      "paginate results": [
        ""
      ],
      "number of entries per request": [
        ""
      ],
      "Show a discovered host": [
        ""
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        ""
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        ""
      ],
      "Provision a discovered host": [
        ""
      ],
      "required if host is managed and value is not inherited from host group": [
        ""
      ],
      "not required if using a subnet with DHCP proxy": [
        ""
      ],
      "not required if it's a virtual machine": [
        ""
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        ""
      ],
      "required if host is managed and custom partition has not been defined": [
        ""
      ],
      "Host's owner type": [
        ""
      ],
      "Host's parameters (array or indexed hash)": [
        ""
      ],
      "Name of the parameter": [
        ""
      ],
      "Parameter value": [
        ""
      ],
      "Type of value": [
        ""
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        ""
      ],
      "required if value is not inherited from host group or default password in settings": [
        ""
      ],
      "Delete a discovered host": [
        ""
      ],
      "Upload facts for a host, creating the host if required": [
        ""
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        ""
      ],
      "Execute rules against a discovered host": [
        ""
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        ""
      ],
      "Unable to provision %{host}: %{errors}": [
        ""
      ],
      "No rule found for host %s": [
        ""
      ],
      "Execute rules against all currently discovered hosts": [
        ""
      ],
      "Errors during auto provisioning: %s": [
        ""
      ],
      "No discovered hosts to provision": [
        ""
      ],
      "%s discovered hosts were provisioned": [
        ""
      ],
      "Refreshing the facts of a discovered host": [
        ""
      ],
      "Rebooting a discovered host": [
        ""
      ],
      "Rebooting all discovered hosts": [
        ""
      ],
      "Discovered hosts are rebooting now": [
        ""
      ],
      "List all discovery rules": [
        ""
      ],
      "Show a discovery rule": [
        ""
      ],
      "represents rule name shown to the users": [
        ""
      ],
      "query to match discovered hosts for the particular rule": [
        ""
      ],
      "the hostgroup that is used to auto provision a host": [
        ""
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        ""
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        ""
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        ""
      ],
      "flag is used for temporary shutdown of rules": [
        ""
      ],
      "location ID for provisioned hosts": [
        ""
      ],
      "organization ID for provisioned hosts": [
        ""
      ],
      "Create a discovery rule": [
        ""
      ],
      "Update a rule": [
        ""
      ],
      "Delete a rule": [
        ""
      ],
      "List all fact values of a given discovered host": [
        ""
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        ""
      ],
      "No hostgroup associated with rule '%s'": [
        ""
      ],
      "Errors during reboot: %s": [
        ""
      ],
      "No discovered hosts to reboot": [
        ""
      ],
      "Successfully provisioned %s": [
        ""
      ],
      "Facts refreshed for %s": [
        ""
      ],
      "Failed to refresh facts for %s": [
        ""
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        ""
      ],
      "Host of type %s can not be rebooted": [
        ""
      ],
      "Rebooting host %s": [
        ""
      ],
      "Failed to reboot host %s": [
        ""
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        ""
      ],
      "Failed to reboot hosts with error %s": [
        ""
      ],
      "Destroyed selected hosts": [
        ""
      ],
      "The following hosts were not deleted: %s": [
        ""
      ],
      "Failed to auto provision host %s: %s": [
        ""
      ],
      "Discovered hosts are provisioning now": [
        ""
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        ""
      ],
      "No hosts selected": [
        ""
      ],
      "Something went wrong while selecting hosts - %s": [
        ""
      ],
      "Rule enabled": [
        ""
      ],
      "Rule disabled": [
        ""
      ],
      "Auto Provision": [
        ""
      ],
      "Refresh facts": [
        ""
      ],
      "Reboot": [
        ""
      ],
      "Back": [
        ""
      ],
      "Select Action": [
        ""
      ],
      "Delete %s?": [
        ""
      ],
      "Assign Organization": [
        ""
      ],
      "Assign Location": [
        ""
      ],
      "Delete": [
        ""
      ],
      "%s - The following hosts are about to be changed": [
        ""
      ],
      "N/A": [
        ""
      ],
      "New in the last 24 hours": [
        ""
      ],
      "Not reported in more than 7 days": [
        ""
      ],
      "Reported in the last 7 days": [
        ""
      ],
      "Provision": [
        ""
      ],
      "Discovered Hosts": [
        ""
      ],
      "Associated Hosts": [
        ""
      ],
      "Disable": [
        ""
      ],
      "Disable rule '%s'?": [
        ""
      ],
      "Enable": [
        ""
      ],
      "Enable rule '%s'?": [
        ""
      ],
      "Clone": [
        ""
      ],
      "Delete rule '%s'?": [
        ""
      ],
      "Invalid user type of %s was provided": [
        ""
      ],
      "Discovered hosts summary": [
        ""
      ],
      "can't contain white spaces.": [
        ""
      ],
      "must start with a letter or ERB.": [
        ""
      ],
      "must be present.": [
        ""
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "",
        ""
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "",
        ""
      ],
      "Fact + prefix": [
        ""
      ],
      "Random name": [
        ""
      ],
      "MAC-based name": [
        ""
      ],
      "Invalid facts, must be a Hash": [
        ""
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        ""
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        ""
      ],
      "Facts could not be imported": [
        ""
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        ""
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        ""
      ],
      "Unable to perform %{action} on %{ips}": [
        ""
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        ""
      ],
      "Invalid hostname: Could not normalize the hostname": [
        ""
      ],
      "Reloading kernel on %s": [
        ""
      ],
      "Rebooting %s": [
        ""
      ],
      "Kexec template not associated with operating system": [
        ""
      ],
      "Kernel kexec URL is invalid: '%s'": [
        ""
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        ""
      ],
      "Rebuild DNS for %s": [
        ""
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        ""
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        ""
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        ""
      ],
      "Highlights": [
        ""
      ],
      "Storage": [
        ""
      ],
      "Hardware": [
        ""
      ],
      "Network": [
        ""
      ],
      "Software": [
        ""
      ],
      "IPMI": [
        ""
      ],
      "Miscellaneous": [
        ""
      ],
      "IPAM must be configured for subnet '%s'": [
        ""
      ],
      "Options must be hash": [
        ""
      ],
      "Option 'url' must be provided": [
        ""
      ],
      "Option 'url' must be valid URI: %s": [
        ""
      ],
      "Image API returned HTTP/%{code} with '%{body}": [
        ""
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        ""
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        ""
      ],
      "Discovered Host": [
        "",
        ""
      ],
      "No discovered hosts available": [
        ""
      ],
      "Host": [
        ""
      ],
      "Model": [
        ""
      ],
      "CPUs": [
        ""
      ],
      "Memory": [
        ""
      ],
      "Customize Host": [
        ""
      ],
      "Create Host": [
        ""
      ],
      "Select all items in this page": [
        ""
      ],
      "items selected. Uncheck to Clear": [
        ""
      ],
      "Name": [
        ""
      ],
      "IP Address": [
        ""
      ],
      "Disk Count": [
        ""
      ],
      "Disks Size": [
        ""
      ],
      "Location": [
        ""
      ],
      "Organization": [
        ""
      ],
      "Subnet": [
        ""
      ],
      "Last Facts Upload": [
        ""
      ],
      "Actions": [
        ""
      ],
      "Please Confirm": [
        ""
      ],
      "Cancel": [
        ""
      ],
      "Submit": [
        ""
      ],
      "Provision %s": [
        ""
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        ""
      ],
      "Select location": [
        ""
      ],
      "Select organization": [
        ""
      ],
      "Discovered host: %s": [
        ""
      ],
      "Interfaces": [
        ""
      ],
      "Type": [
        ""
      ],
      "Identifier": [
        ""
      ],
      "MAC address": [
        ""
      ],
      "IP address": [
        ""
      ],
      "Collapse All": [
        ""
      ],
      "Summary report for discovered hosts from Foreman": [
        ""
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        ""
      ],
      "Summary from %{time} ago to %{now}": [
        ""
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        ""
      ],
      "Disk count": [
        ""
      ],
      "Disks size": [
        ""
      ],
      "No discovered hosts for the selected period": [
        ""
      ],
      "Foreman discovered hosts summary": [
        ""
      ],
      "No new discovered hosts for this period": [
        ""
      ],
      "Primary": [
        ""
      ],
      "Locations": [
        ""
      ],
      "Organizations": [
        ""
      ],
      "Target host group for this rule with all properties set": [
        ""
      ],
      "Hostname for provisioned hosts": [
        ""
      ],
      "Hosts Limit": [
        ""
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        ""
      ],
      "Rule priority (lower integer means higher priority)": [
        ""
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        ""
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        ""
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        ""
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        ""
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        ""
      ],
      "Clone %s": [
        ""
      ],
      "Edit %s": [
        ""
      ],
      "Discovery Rules": [
        ""
      ],
      "Create Rule": [
        ""
      ],
      "DiscoveryRule|Name": [
        ""
      ],
      "DiscoveryRule|Priority": [
        ""
      ],
      "DiscoveryRule|Query": [
        ""
      ],
      "Host Group": [
        ""
      ],
      "Hosts/Limit": [
        ""
      ],
      "DiscoveryRule|Enabled": [
        ""
      ],
      "New Discovery Rule": [
        ""
      ],
      "Discovered Rules": [
        ""
      ],
      "A summary of discovered hosts": [
        ""
      ],
      "New hosts": [
        ""
      ],
      "One or more hosts have been discovered": [
        ""
      ],
      "Details": [
        ""
      ],
      "Hosts": [
        ""
      ],
      "Error message goes here": [
        ""
      ],
      "Discovery": [
        ""
      ],
      "Discovery location": [
        ""
      ],
      "The default location to place discovered hosts in": [
        ""
      ],
      "Discovery organization": [
        ""
      ],
      "The default organization to place discovered hosts in": [
        ""
      ],
      "Interface fact": [
        ""
      ],
      "Fact name to use for primary interface detection": [
        ""
      ],
      "Create bond interfaces": [
        ""
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        ""
      ],
      "Clean all facts": [
        ""
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        ""
      ],
      "Hostname facts": [
        ""
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        ""
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        ""
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        ""
      ],
      "Hostname prefix": [
        ""
      ],
      "The default prefix to use for the host name, must start with a letter": [
        ""
      ],
      "Fact columns": [
        ""
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        ""
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        ""
      ],
      "Storage facts": [
        ""
      ],
      "Regex to organize facts for storage section": [
        ""
      ],
      "Software facts": [
        ""
      ],
      "Regex to organize facts for software section": [
        ""
      ],
      "Hardware facts": [
        ""
      ],
      "Regex to organize facts for hardware section": [
        ""
      ],
      "Network facts": [
        ""
      ],
      "Regex to organize facts for network section": [
        ""
      ],
      "IPMI facts": [
        ""
      ],
      "Regex to organize facts for ipmi section": [
        ""
      ],
      "Lock PXE": [
        ""
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        ""
      ],
      "Locked PXELinux template name": [
        ""
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        ""
      ],
      "Locked PXEGrub template name": [
        ""
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        ""
      ],
      "Locked PXEGrub2 template name": [
        ""
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        ""
      ],
      "Force DNS": [
        ""
      ],
      "Force DNS entries creation when provisioning discovered host": [
        ""
      ],
      "Error on existing NIC": [
        ""
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        ""
      ],
      "Type of name generator": [
        ""
      ],
      "Discovery hostname naming pattern": [
        ""
      ],
      "Prefer IPv6": [
        ""
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        ""
      ],
      "Discovery Proxy": [
        ""
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        ""
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        ""
      ],
      "For more information please see ": [
        ""
      ],
      "documentation": [
        ""
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        ""
      ],
      "Foreman Discovery": [
        ""
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        ""
      ],
      "Remote action:": [
        ""
      ],
      "Import Puppet classes": [
        ""
      ],
      "Import facts": [
        ""
      ],
      "Action with sub plans": [
        ""
      ]
    }
  }
};