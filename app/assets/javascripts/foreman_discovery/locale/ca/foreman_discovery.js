 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['ca'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Robert Antoni Buj i Gelonch <rbuj@fedoraproject.org>, 2017",
        "Language-Team": "Catalan (http://www.transifex.com/foreman/foreman/language/ca/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "ca",
        "Plural-Forms": "nplurals=2; plural=(n != 1);",
        "lang": "ca",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=2; plural=(n != 1);"
      },
      "List all discovered hosts": [
        "Llista tots els amfitrions descoberts"
      ],
      "filter results": [
        "filtra els resultats"
      ],
      "sort results": [
        "ordena els resultats"
      ],
      "paginate results": [
        "pagina els resultats"
      ],
      "number of entries per request": [
        "Nombre d'entrades per petició"
      ],
      "Show a discovered host": [
        "Mostra un amfitrió descobert"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        ""
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Crea un amfitrió descobert per a provar-ho  (utilitzeu /facts per crear amfitrions nous)"
      ],
      "Provision a discovered host": [
        "Aprovisiona un amfitrió descobert"
      ],
      "required if host is managed and value is not inherited from host group": [
        ""
      ],
      "not required if using a subnet with DHCP proxy": [
        "no es requereix si s'està utilitzant una subxarxa amb servidor intermediari DHCP"
      ],
      "not required if it's a virtual machine": [
        ""
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        ""
      ],
      "required if host is managed and custom partition has not been defined": [
        "es requereix si l'amfitrió està gestionat i no s'ha definit la partició personalitzada"
      ],
      "Host's owner type": [
        "Tipus de propietari de l'amfitrió"
      ],
      "Host's parameters (array or indexed hash)": [
        ""
      ],
      "Name of the parameter": [
        "Nom del paràmetre"
      ],
      "Parameter value": [
        "Valor del paràmetre"
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
        "Suprimeix un amfitrió descobert"
      ],
      "Upload facts for a host, creating the host if required": [
        "Puja els objectes d'interès per a un amfitrió, creant el nou amfitrió si fos necessari"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        ""
      ],
      "Execute rules against a discovered host": [
        ""
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "L'amfitrió %{host} va ser aprovisionat amb la regla %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "No es pot aprovisionar a %{host}: %{errors}"
      ],
      "No rule found for host %s": [
        "No s'ha trobat cap regla per a l'amfitrió %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Executa les regles contra tots els amfitrions detectats actualment"
      ],
      "Errors during auto provisioning: %s": [
        "Erros durant l'auto aprovisionament: %s"
      ],
      "No discovered hosts to provision": [
        "Sense amfitrions descoberts per aprovisionar"
      ],
      "%s discovered hosts were provisioned": [
        "%s amfitrions descoberts van ser aprovisionats"
      ],
      "Refreshing the facts of a discovered host": [
        "S'estan refrescant els objectes d'interès d'un amfitrió descobert"
      ],
      "Rebooting a discovered host": [
        "S'està reiniciant un amfitrió descobert"
      ],
      "Rebooting all discovered hosts": [
        "S'estan reiniciant tots els amfitrions descoberts"
      ],
      "Discovered hosts are rebooting now": [
        "Ara s'estan reiniciant els amfitrions descoberts"
      ],
      "List all discovery rules": [
        "Llista totes les regles de descobriment"
      ],
      "Show a discovery rule": [
        "Mostra una regla de descobriment"
      ],
      "represents rule name shown to the users": [
        "representa el nom de la regla que es mostra als usuaris"
      ],
      "query to match discovered hosts for the particular rule": [
        ""
      ],
      "the hostgroup that is used to auto provision a host": [
        "el grup d'amfitrions que s'utilitza per a l'auto aprovisionament d'un amfitrió"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        ""
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "permet la limitació del nombre total màxim dels amfitrions aprovisionats per cada regla"
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
        "Crea una regla de descobriment"
      ],
      "Update a rule": [
        "Actualitza una regla"
      ],
      "Delete a rule": [
        "Suprimeix una regla"
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
        "Errors durant el reinici: %s"
      ],
      "No discovered hosts to reboot": [
        ""
      ],
      "Successfully provisioned %s": [
        ""
      ],
      "Facts refreshed for %s": [
        "Els objectes d'interès que s'han refrescat per a %s"
      ],
      "Failed to refresh facts for %s": [
        "No s'ha pogut refrescar els objectes d'interès per a %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        ""
      ],
      "Host of type %s can not be rebooted": [
        ""
      ],
      "Rebooting host %s": [
        "S'està reiniciant l'amfitrió %s"
      ],
      "Failed to reboot host %s": [
        "No s'ha pogut reiniciar l'amfitrió %s."
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        ""
      ],
      "Failed to reboot hosts with error %s": [
        ""
      ],
      "Destroyed selected hosts": [
        "S'han destruït els amfitrions seleccionats"
      ],
      "The following hosts were not deleted: %s": [
        ""
      ],
      "Failed to auto provision host %s: %s": [
        "No s'ha pogut auto aprovisionar l'amfitrió %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Els amfitrions descoberts ara tenen aprovisionament"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        "No s'ha trobat cap amfitrió amb aquest ID o nom"
      ],
      "No hosts selected": [
        "Cap amfitrió seleccionat"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Alguna cosa va anar malament mentre se seleccionaven els amfitrions - %s"
      ],
      "Rule enabled": [
        "Regla habilitada"
      ],
      "Rule disabled": [
        "Regla inhabilitada"
      ],
      "Auto Provision": [
        "Auto aprovisiona"
      ],
      "Refresh facts": [
        "Refresca els objectes d'interès"
      ],
      "Reboot": [
        "Reinicia"
      ],
      "Back": [
        "Enrere"
      ],
      "Select Action": [
        "Selecciona l'acció"
      ],
      "Delete %s?": [
        "Voleu suprimir %s?"
      ],
      "Assign Organization": [
        "Assigna l'organització"
      ],
      "Assign Location": [
        "Assigna la ubicació"
      ],
      "Delete": [
        "Suprimeix"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - Els següents amfitrions estan a punt de ser canviats"
      ],
      "N/A": [
        "N/D"
      ],
      "New in the last 24 hours": [
        "Nou en les últimes 24 hores"
      ],
      "Not reported in more than 7 days": [
        "No es va informar en més de 7 dies"
      ],
      "Reported in the last 7 days": [
        "Es va informar en els últims 7 dies"
      ],
      "Provision": [
        "Aprovisiona"
      ],
      "Discovered Hosts": [
        ""
      ],
      "Associated Hosts": [
        ""
      ],
      "Disable": [
        "Inhabilita"
      ],
      "Disable rule '%s'?": [
        ""
      ],
      "Enable": [
        "Habilita"
      ],
      "Enable rule '%s'?": [
        ""
      ],
      "Clone": [
        "Clona"
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
        "no pot contenir espais en blanc."
      ],
      "must start with a letter or ERB.": [
        "ha de començar amb una lletra o ERB."
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
        "Objectes d'interès no vàlids, han de tenir un Hash"
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
        "No s'han pogut obtenir els objectes d'interès del servidor intermediari %{url}: %{error}"
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
        "S'està tornant a carregar el kernel a %s"
      ],
      "Rebooting %s": [
        "S'està reiniciant %s"
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
        "Emmagatzematge"
      ],
      "Hardware": [
        "Maquinari"
      ],
      "Network": [
        "Xarxa"
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
        "Amfitrió"
      ],
      "Model": [
        "Model"
      ],
      "CPUs": [
        "Les CPU"
      ],
      "Memory": [
        "Memòria"
      ],
      "Customize Host": [
        ""
      ],
      "Create Host": [
        "Crea un amfitrió"
      ],
      "Select all items in this page": [
        "Selecciona tots els ítems en aquesta pàgina"
      ],
      "items selected. Uncheck to Clear": [
        "ítems seleccionats. Desmarca per netejar"
      ],
      "Name": [
        "Nom"
      ],
      "IP Address": [
        "Adreça IP"
      ],
      "Disk Count": [
        ""
      ],
      "Disks Size": [
        ""
      ],
      "Location": [
        "Ubicació"
      ],
      "Organization": [
        "Organització"
      ],
      "Subnet": [
        "Subxarxa"
      ],
      "Last Facts Upload": [
        ""
      ],
      "Actions": [
        "Accions"
      ],
      "Please Confirm": [
        "Si us plau, confirmeu"
      ],
      "Cancel": [
        "Cancel·la"
      ],
      "Submit": [
        "Envia"
      ],
      "Provision %s": [
        ""
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        ""
      ],
      "Select location": [
        "Selecciona la ubicació"
      ],
      "Select organization": [
        "Selecciona l'organització"
      ],
      "Discovered host: %s": [
        "Amfitrions descoberts: %s"
      ],
      "Interfaces": [
        "Interfícies"
      ],
      "Type": [
        "Tipus"
      ],
      "Identifier": [
        "Identificador"
      ],
      "MAC address": [
        "Adreça MAC"
      ],
      "IP address": [
        "Adreça IP"
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
        "Nombre de discs"
      ],
      "Disks size": [
        "Mida de disc"
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
        "Primària"
      ],
      "Locations": [
        "Ubicacions"
      ],
      "Organizations": [
        "Organitzacions"
      ],
      "Target host group for this rule with all properties set": [
        ""
      ],
      "Hostname for provisioned hosts": [
        "Nom d'amfitrió per als amfitrions aprovisionats"
      ],
      "Hosts Limit": [
        "Límit d'amfitrions"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Nombre màxim d'amfitrions aprovisionats amb aquesta regla (0 = il·limitat)"
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
        "Clona %s"
      ],
      "Edit %s": [
        "Edita %s"
      ],
      "Discovery Rules": [
        "Regles de descobriment"
      ],
      "Create Rule": [
        ""
      ],
      "DiscoveryRule|Name": [
        "Nom"
      ],
      "DiscoveryRule|Priority": [
        "Prioritat"
      ],
      "DiscoveryRule|Query": [
        "Consulta"
      ],
      "Host Group": [
        "Grup dels amfitrions"
      ],
      "Hosts/Limit": [
        ""
      ],
      "DiscoveryRule|Enabled": [
        "Habilitada"
      ],
      "New Discovery Rule": [
        "Regla de descobriment nova"
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
        "Detalls"
      ],
      "Hosts": [
        "Amfitrions"
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
        "Expressió regular per a organitzar els objectes d'interès per a la secció d'emmagatzematge"
      ],
      "Software facts": [
        ""
      ],
      "Regex to organize facts for software section": [
        "Expressió regular per a organitzar els objectes d'interès per a la secció de programari"
      ],
      "Hardware facts": [
        ""
      ],
      "Regex to organize facts for hardware section": [
        "Expressió regular per a organitzar els objectes d'interès per a la secció de programari"
      ],
      "Network facts": [
        ""
      ],
      "Regex to organize facts for network section": [
        "Expressió regular per a organitzar els objectes d'interès per a la secció de xarxa"
      ],
      "IPMI facts": [
        ""
      ],
      "Regex to organize facts for ipmi section": [
        "Expressió regular per a organitzar els objectes d'interès per a la secció ipmi"
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