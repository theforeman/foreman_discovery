 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['en_GB'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Andi Chandler <andi@gowling.com>, 2015-2019",
        "Language-Team": "English (United Kingdom) (http://www.transifex.com/foreman/foreman/language/en_GB/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "en_GB",
        "Plural-Forms": "nplurals=2; plural=(n != 1);",
        "lang": "en_GB",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=2; plural=(n != 1);"
      },
      "List all discovered hosts": [
        "List all discovered hosts"
      ],
      "filter results": [
        "filter results"
      ],
      "sort results": [
        "sort results"
      ],
      "paginate results": [
        "paginate results"
      ],
      "number of entries per request": [
        "number of entries per request"
      ],
      "Show a discovered host": [
        "Show a discovered host"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "DHCP filename option (Grub2 or PXELinux by default)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Create a discovered host for testing (use /facts to create new hosts)"
      ],
      "Provision a discovered host": [
        "Provision a discovered host"
      ],
      "required if host is managed and value is not inherited from host group": [
        ""
      ],
      "not required if using a subnet with DHCP proxy": [
        "not required if using a subnet with DHCP proxy"
      ],
      "not required if it's a virtual machine": [
        "not required if it's a virtual machine"
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
        "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "required if value is not inherited from host group or default password in settings"
      ],
      "Delete a discovered host": [
        "Delete a discovered host"
      ],
      "Upload facts for a host, creating the host if required": [
        "Upload facts for a host, creating the host if required"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)"
      ],
      "Execute rules against a discovered host": [
        "Execute rules against a discovered host"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "Host %{host} was provisioned with rule %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "Unable to provision %{host}: %{errors}"
      ],
      "No rule found for host %s": [
        "No rule found for host %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Execute rules against all currently discovered hosts"
      ],
      "Errors during auto provisioning: %s": [
        "Errors during auto provisioning: %s"
      ],
      "No discovered hosts to provision": [
        "No discovered hosts to provision"
      ],
      "%s discovered hosts were provisioned": [
        "%s discovered hosts were provisioned"
      ],
      "Refreshing the facts of a discovered host": [
        "Refreshing the facts of a discovered host"
      ],
      "Rebooting a discovered host": [
        "Rebooting a discovered host"
      ],
      "Rebooting all discovered hosts": [
        "Rebooting all discovered hosts"
      ],
      "Discovered hosts are rebooting now": [
        "Discovered hosts are rebooting now"
      ],
      "List all discovery rules": [
        "List all discovery rules"
      ],
      "Show a discovery rule": [
        "Show a discovery rule"
      ],
      "represents rule name shown to the users": [
        "represents rule name shown to the users"
      ],
      "query to match discovered hosts for the particular rule": [
        "query to match discovered hosts for the particular rule"
      ],
      "the hostgroup that is used to auto provision a host": [
        "the hostgroup that is used to auto provision a host"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "defines a pattern to assign human-readable hostnames to the matching hosts"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "enables to limit maximum amount of provisioned hosts per rule"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "puts the rules in order, low numbers go first. Must be greater then zero"
      ],
      "flag is used for temporary shutdown of rules": [
        "flag is used for temporary shutdown of rules"
      ],
      "location ID for provisioned hosts": [
        "location ID for provisioned hosts"
      ],
      "organization ID for provisioned hosts": [
        "organisation ID for provisioned hosts"
      ],
      "Create a discovery rule": [
        "Create a discovery rule"
      ],
      "Update a rule": [
        "Update a rule"
      ],
      "Delete a rule": [
        "Delete a rule"
      ],
      "List all fact values of a given discovered host": [
        "List all fact values of a given discovered host"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "Unable to find a discovery rule, no host provided (check permissions)"
      ],
      "No hostgroup associated with rule '%s'": [
        "No hostgroup associated with rule '%s'"
      ],
      "Errors during reboot: %s": [
        "Errors during reboot: %s"
      ],
      "No discovered hosts to reboot": [
        "No discovered hosts to reboot"
      ],
      "Successfully provisioned %s": [
        "Successfully provisioned %s"
      ],
      "Facts refreshed for %s": [
        "Facts refreshed for %s"
      ],
      "Failed to refresh facts for %s": [
        "Failed to refresh facts for %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "Failed to refresh facts for %{hostname} with error %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "Host of type %s can not be rebooted"
      ],
      "Rebooting host %s": [
        "Rebooting host %s"
      ],
      "Failed to reboot host %s": [
        "Failed to reboot host %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Failed to reboot host %{hostname} with error %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "Failed to reboot hosts with error %s"
      ],
      "Destroyed selected hosts": [
        "Destroyed selected hosts"
      ],
      "The following hosts were not deleted: %s": [
        "The following hosts were not deleted: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Failed to auto provision host %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Discovered hosts are provisioning now"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        "No hosts were found with that id or name"
      ],
      "No hosts selected": [
        "No hosts selected"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Something went wrong while selecting hosts - %s"
      ],
      "Rule enabled": [
        "Rule enabled"
      ],
      "Rule disabled": [
        "Rule disabled"
      ],
      "Auto Provision": [
        "Auto Provision"
      ],
      "Refresh facts": [
        "Refresh facts"
      ],
      "Reboot": [
        "Reboot"
      ],
      "Back": [
        "Back"
      ],
      "Select Action": [
        "Select Action"
      ],
      "Delete %s?": [
        "Delete %s?"
      ],
      "Assign Organization": [
        "Assign Organisation"
      ],
      "Assign Location": [
        "Assign Location"
      ],
      "Delete": [
        "Delete"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - The following hosts are about to be changed"
      ],
      "N/A": [
        "N/A"
      ],
      "New in the last 24 hours": [
        "New in the last 24 hours"
      ],
      "Not reported in more than 7 days": [
        "Not reported in more than 7 days"
      ],
      "Reported in the last 7 days": [
        "Reported in the last 7 days"
      ],
      "Provision": [
        "Provision"
      ],
      "Discovered Hosts": [
        "Discovered Hosts"
      ],
      "Associated Hosts": [
        "Associated Hosts"
      ],
      "Disable": [
        "Disable"
      ],
      "Disable rule '%s'?": [
        "Disable rule '%s'?"
      ],
      "Enable": [
        "Enable"
      ],
      "Enable rule '%s'?": [
        "Enable rule '%s'?"
      ],
      "Clone": [
        ""
      ],
      "Delete rule '%s'?": [
        "Delete rule '%s'?"
      ],
      "Invalid user type of %s was provided": [
        "Invalid user type of %s was provided"
      ],
      "Discovered hosts summary": [
        "Discovered hosts summary"
      ],
      "can't contain white spaces.": [
        "can't contain white spaces."
      ],
      "must start with a letter or ERB.": [
        "must start with a letter or ERB."
      ],
      "must be present.": [
        "must be present."
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "Host group organisation %s must also be associated to the discovery rule",
        "Host group organisations %s must also be associated to the discovery rule"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "Host group location %s must also be associated to the discovery rule",
        "Host group locations %s must also be associated to the discovery rule"
      ],
      "Fact + prefix": [
        "Fact + prefix"
      ],
      "Random name": [
        "Random name"
      ],
      "MAC-based name": [
        "MAC-based name"
      ],
      "Invalid facts, must be a Hash": [
        "Invalid facts, must be a Hash"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s"
      ],
      "Facts could not be imported": [
        "Facts could not be imported"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "Could not get facts from proxy %{url}: %{error}"
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
        "Invalid hostname: Could not normalise the hostname"
      ],
      "Reloading kernel on %s": [
        "Reloading kernel on %s"
      ],
      "Rebooting %s": [
        "Rebooting %s"
      ],
      "Kexec template not associated with operating system": [
        "Kexec template not associated with operating system"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "Kernel kexec URL is invalid: '%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "Init RAM kexec URL is invalid: '%s'"
      ],
      "Rebuild DNS for %s": [
        "Rebuild DNS for %s"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "Discovery fact parser does not work with non-discovery host '%{host}'"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}"
      ],
      "Highlights": [
        "Highlights"
      ],
      "Storage": [
        "Storage"
      ],
      "Hardware": [
        "Hardware"
      ],
      "Network": [
        "Network"
      ],
      "Software": [
        "Software"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "Miscellaneous"
      ],
      "IPAM must be configured for subnet '%s'": [
        "IPAM must be configured for subnet '%s'"
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
        "Image API returned HTTP/%{code} with '%{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})"
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
        "No discovered hosts available"
      ],
      "Host": [
        "Host"
      ],
      "Model": [
        "Model"
      ],
      "CPUs": [
        "CPUs"
      ],
      "Memory": [
        "Memory"
      ],
      "Customize Host": [
        "Customise Host"
      ],
      "Create Host": [
        "Create Host"
      ],
      "Select all items in this page": [
        "Select all items in this page"
      ],
      "items selected. Uncheck to Clear": [
        "items selected. Uncheck to Clear"
      ],
      "Name": [
        "Name"
      ],
      "IP Address": [
        "IP Address"
      ],
      "Disk Count": [
        "Disk Count"
      ],
      "Disks Size": [
        "Disks Size"
      ],
      "Location": [
        "Location"
      ],
      "Organization": [
        "Organisation"
      ],
      "Subnet": [
        "Subnet"
      ],
      "Last Facts Upload": [
        "Last Facts Upload"
      ],
      "Actions": [
        "Actions"
      ],
      "Please Confirm": [
        "Please Confirm"
      ],
      "Cancel": [
        "Cancel"
      ],
      "Submit": [
        "Submit"
      ],
      "Provision %s": [
        "Provision %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "This might take a while, as all hosts, facts and reports will be destroyed as well"
      ],
      "Select location": [
        "Select location"
      ],
      "Select organization": [
        "Select organisation"
      ],
      "Discovered host: %s": [
        "Discovered host: %s"
      ],
      "Interfaces": [
        "Interfaces"
      ],
      "Type": [
        "Type"
      ],
      "Identifier": [
        "Identifier"
      ],
      "MAC address": [
        "MAC address"
      ],
      "IP address": [
        "IP address"
      ],
      "Collapse All": [
        "Collapse All"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Summary report for discovered hosts from Foreman"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b> Discovered hosts summary"
      ],
      "Summary from %{time} ago to %{now}": [
        "Summary from %{time} ago to %{now}"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Discovered hosts from Foreman server at %{foreman_url}"
      ],
      "Disk count": [
        "Disk count"
      ],
      "Disks size": [
        "Disks size"
      ],
      "No discovered hosts for the selected period": [
        "No discovered hosts for the selected period"
      ],
      "Foreman discovered hosts summary": [
        "Foreman discovered hosts summary"
      ],
      "No new discovered hosts for this period": [
        "No new discovered hosts for this period"
      ],
      "Primary": [
        "Primary"
      ],
      "Locations": [
        "Locations"
      ],
      "Organizations": [
        "Organisations"
      ],
      "Target host group for this rule with all properties set": [
        "Target host group for this rule with all properties set"
      ],
      "Hostname for provisioned hosts": [
        "Hostname for provisioned hosts"
      ],
      "Hosts Limit": [
        "Hosts Limit"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Maximum hosts provisioned with this rule (0 = unlimited)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Rule priority (lower integer means higher priority)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB)."
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "Domain will be appended automatically. A hostname based on MAC address will be used when left blank."
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "In addition to @host attribute function rand for random integers is available. Examples:"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "When creating hostname patterns, make sure the resulting host names are unique."
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID)."
      ],
      "Clone %s": [
        ""
      ],
      "Edit %s": [
        "Edit %s"
      ],
      "Discovery Rules": [
        "Discovery Rules"
      ],
      "Create Rule": [
        "Create Rule"
      ],
      "DiscoveryRule|Name": [
        "Name"
      ],
      "DiscoveryRule|Priority": [
        "Priority"
      ],
      "DiscoveryRule|Query": [
        "Query"
      ],
      "Host Group": [
        "Host Group"
      ],
      "Hosts/Limit": [
        "Hosts/Limit"
      ],
      "DiscoveryRule|Enabled": [
        "Enabled"
      ],
      "New Discovery Rule": [
        "New Discovery Rule"
      ],
      "Discovered Rules": [
        ""
      ],
      "A summary of discovered hosts": [
        "A summary of discovered hosts"
      ],
      "New hosts": [
        ""
      ],
      "One or more hosts have been discovered": [
        "One or more hosts have been discovered"
      ],
      "Details": [
        "Details"
      ],
      "Hosts": [
        "Hosts"
      ],
      "Error message goes here": [
        ""
      ],
      "Discovery": [
        ""
      ],
      "Discovery location": [
        "Discovery location"
      ],
      "The default location to place discovered hosts in": [
        "The default location to place discovered hosts in"
      ],
      "Discovery organization": [
        "Discovery organisation"
      ],
      "The default organization to place discovered hosts in": [
        "The default organisation to place discovered hosts in"
      ],
      "Interface fact": [
        "Interface fact"
      ],
      "Fact name to use for primary interface detection": [
        "Fact name to use for primary interface detection"
      ],
      "Create bond interfaces": [
        "Create bond interfaces"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)"
      ],
      "Clean all facts": [
        "Clean all facts"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "Clean all reported facts during provisioning (except discovery facts)"
      ],
      "Hostname facts": [
        "Hostname facts"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "Auto provisioning"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "Automatically provision newly discovered hosts, according to the provisioning rules"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "Automatically reboot or kexec discovered host during provisioning"
      ],
      "Hostname prefix": [
        "Hostname prefix"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "The default prefix to use for the host name, must start with a letter"
      ],
      "Fact columns": [
        "Fact columns"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "Highlighted facts"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "Regex to organise facts for highlights section - e.g. ^(abc|cde)$"
      ],
      "Storage facts": [
        "Storage facts"
      ],
      "Regex to organize facts for storage section": [
        "Regex to organise facts for storage section"
      ],
      "Software facts": [
        "Software facts"
      ],
      "Regex to organize facts for software section": [
        "Regex to organise facts for software section"
      ],
      "Hardware facts": [
        "Hardware facts"
      ],
      "Regex to organize facts for hardware section": [
        "Regex to organise facts for hardware section"
      ],
      "Network facts": [
        "Network facts"
      ],
      "Regex to organize facts for network section": [
        "Regex to organise facts for network section"
      ],
      "IPMI facts": [
        "IPMI facts"
      ],
      "Regex to organize facts for ipmi section": [
        "Regex to organise facts for IPMI section"
      ],
      "Lock PXE": [
        "Lock PXE"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "Automatically generate PXE configuration to pin a newly discovered host to discovery"
      ],
      "Locked PXELinux template name": [
        "Locked PXELinux template name"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "PXELinux template to be used when pinning a host to discovery"
      ],
      "Locked PXEGrub template name": [
        "Locked PXEGrub template name"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "PXEGrub template to be used when pinning a host to discovery"
      ],
      "Locked PXEGrub2 template name": [
        "Locked PXEGrub2 template name"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "PXEGrub2 template to be used when pinning a host to discovery"
      ],
      "Force DNS": [
        "Force DNS"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "Force DNS entries creation when provisioning discovered host"
      ],
      "Error on existing NIC": [
        "Error on existing NIC"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)"
      ],
      "Type of name generator": [
        "Type of name generator"
      ],
      "Discovery hostname naming pattern": [
        "Discovery hostname naming pattern"
      ],
      "Prefer IPv6": [
        ""
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        ""
      ],
      "Discovery Proxy": [
        "Discovery Proxy"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "Discovery Proxy to use within this subnet for managing connection to discovered hosts"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts"
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
        "Remote action:"
      ],
      "Import Puppet classes": [
        "Import Puppet classes"
      ],
      "Import facts": [
        "Import facts"
      ],
      "Action with sub plans": [
        "Action with sub plans"
      ]
    }
  }
};