 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['it'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "caifti <caifti@gmail.com>, 2014",
        "Language-Team": "Italian (http://www.transifex.com/foreman/foreman/language/it/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "it",
        "Plural-Forms": "nplurals=3; plural=n == 1 ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;",
        "lang": "it",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=3; plural=n == 1 ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;"
      },
      "List all discovered hosts": [
        "Elenca tutti gli host rilevati"
      ],
      "filter results": [
        "filtra i risultati"
      ],
      "sort results": [
        "ordina risultati"
      ],
      "paginate results": [
        "paginazione risultati"
      ],
      "number of entries per request": [
        "numero di voci per richiesta"
      ],
      "Show a discovered host": [
        "Visualizza un host rilevato"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        ""
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        ""
      ],
      "Provision a discovered host": [
        "Esegui il provisioning di un host rilevato"
      ],
      "required if host is managed and value is not inherited from host group": [
        "necessario se l'host è gestito ed il valore non è stato ereditato da un gruppo di host"
      ],
      "not required if using a subnet with DHCP proxy": [
        "non necessario se si utilizza una sottorete con DHCP proxy"
      ],
      "not required if it's a virtual machine": [
        "non necessario se è una macchina virtuale"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "necessario se non è disponibile imaged based provisioning e l'host è gestito ed il valore non è stato ereditato dal gruppo di host"
      ],
      "required if host is managed and custom partition has not been defined": [
        "necessario se l'host è gestito e la partizione personalizzata non è stata definita"
      ],
      "Host's owner type": [
        "Tipo di proprietario dell'host"
      ],
      "Host's parameters (array or indexed hash)": [
        "Parametri dell'host (array o hash indicizzato)"
      ],
      "Name of the parameter": [
        "Nome del parametro"
      ],
      "Parameter value": [
        "Valore parametro"
      ],
      "Type of value": [
        "Tipo di valore"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID per controllare gli stati dei compiti d'orchestrazione, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "necessario se il valore non è ereditato da un gruppo di host o password predefinita nelle impostazione"
      ],
      "Delete a discovered host": [
        "Rimuovi un host rilevato"
      ],
      "Upload facts for a host, creating the host if required": [
        "Carica gli eventi per un host creando, se necessario, un host"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        ""
      ],
      "Execute rules against a discovered host": [
        "Esegui le regole nei confronti di un host rilevato"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "È stato eseguito il provisioning dell'host %{host} con la regola %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        ""
      ],
      "No rule found for host %s": [
        "Nessuna regola trovata per l'host %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Esegui le regole nei confronti degli host attualemente rilevati"
      ],
      "Errors during auto provisioning: %s": [
        "Errore durante auto provisioning: %s"
      ],
      "No discovered hosts to provision": [
        "Nessun host rilevato per il provisioning"
      ],
      "%s discovered hosts were provisioned": [
        ""
      ],
      "Refreshing the facts of a discovered host": [
        "Aggiornamento eventi di un host rilevato"
      ],
      "Rebooting a discovered host": [
        "Riavvio di un host rilevato"
      ],
      "Rebooting all discovered hosts": [
        ""
      ],
      "Discovered hosts are rebooting now": [
        ""
      ],
      "List all discovery rules": [
        "Elenca tutte le regole per la scoperta"
      ],
      "Show a discovery rule": [
        "Visualizza una regola per la scoperta"
      ],
      "represents rule name shown to the users": [
        "rappresenta il nome della regola da mostrare agli utenti"
      ],
      "query to match discovered hosts for the particular rule": [
        "interrogazione da corrispondere agli host rilevati per una regola particolare"
      ],
      "the hostgroup that is used to auto provision a host": [
        "gruppo di host usato per l'auto provision di un host"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "definisce uno schema per assegnare gli hostname leggibili dall'utente agli host corrispondenti"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "permette di limitare la quantità massima di host con provisioning per regola"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "ordina le regole, i numeri più piccoli hanno maggiore priorità. Deve essere maggiore di zero."
      ],
      "flag is used for temporary shutdown of rules": [
        "il flag viene usato per interrompere momentaneamente le regole"
      ],
      "location ID for provisioned hosts": [
        ""
      ],
      "organization ID for provisioned hosts": [
        ""
      ],
      "Create a discovery rule": [
        "Crea una regola per la scoperta"
      ],
      "Update a rule": [
        "Aggiorna una regola"
      ],
      "Delete a rule": [
        "Cancella una regola"
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
        "Eventi aggiornati per %s"
      ],
      "Failed to refresh facts for %s": [
        "Impossibile aggiornare gli eventi per %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        ""
      ],
      "Host of type %s can not be rebooted": [
        "Impossibile eseguire il riavvio sul tipo di host %s "
      ],
      "Rebooting host %s": [
        "Riavvio host %s"
      ],
      "Failed to reboot host %s": [
        "Impossibile eseguire il riavvio dell'host: %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Impossibile eseguire il riavvio dell'host %{hostname} con errore %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        ""
      ],
      "Destroyed selected hosts": [
        "Host selezionati annullati"
      ],
      "The following hosts were not deleted: %s": [
        "I seguenti host non sono stati rilevati: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Impossibile eseguire auto provision dell'host %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Gli host rilevati stanno eseguendo ora il provisioning"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        "Nessun host trovato con l'id o nome indicato"
      ],
      "No hosts selected": [
        "Nessun host selezionato"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Si è verificato un errore durante la selezione degli host - %s"
      ],
      "Rule enabled": [
        "Regola abilitata"
      ],
      "Rule disabled": [
        "Regola disabilitata"
      ],
      "Auto Provision": [
        "Auto Provision"
      ],
      "Refresh facts": [
        "Aggiorna eventi"
      ],
      "Reboot": [
        "Riavvia"
      ],
      "Back": [
        "Indietro"
      ],
      "Select Action": [
        "Seleziona azione"
      ],
      "Delete %s?": [
        "Cancella %s?"
      ],
      "Assign Organization": [
        "Assegna organizzazione"
      ],
      "Assign Location": [
        "Assegna posizione"
      ],
      "Delete": [
        "Cancella"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - I seguenti host stanno per essere modificati"
      ],
      "N/A": [
        "N/A"
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
        "Provisioning"
      ],
      "Discovered Hosts": [
        ""
      ],
      "Associated Hosts": [
        ""
      ],
      "Disable": [
        "Disabilita"
      ],
      "Disable rule '%s'?": [
        ""
      ],
      "Enable": [
        "Abilita"
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
        "non può avere spazi."
      ],
      "must start with a letter or ERB.": [
        "deve iniziare con una lettera o ERB."
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
        "Eventi non validi, deve essere un Hash"
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
        "Impossibile ottenere gli eventi dal proxy %{url}: %{error}"
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
        "Riavvio di %s"
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
        "Storage"
      ],
      "Hardware": [
        "Hardware"
      ],
      "Network": [
        "Rete"
      ],
      "Software": [
        "Software"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "Varie"
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
        "Nessun host rilevato disponibile"
      ],
      "Host": [
        "Host"
      ],
      "Model": [
        "Modello"
      ],
      "CPUs": [
        "CPU"
      ],
      "Memory": [
        "Memoria"
      ],
      "Customize Host": [
        ""
      ],
      "Create Host": [
        "Crea Host"
      ],
      "Select all items in this page": [
        "Seleziona tutti gli oggetti in questa pagina"
      ],
      "items selected. Uncheck to Clear": [
        "oggetti selezionati. Deselezionare per annullare"
      ],
      "Name": [
        "Nome"
      ],
      "IP Address": [
        "Indirizzo IP"
      ],
      "Disk Count": [
        ""
      ],
      "Disks Size": [
        ""
      ],
      "Location": [
        "Posizione"
      ],
      "Organization": [
        "Organizzazione"
      ],
      "Subnet": [
        "Sottorete"
      ],
      "Last Facts Upload": [
        ""
      ],
      "Actions": [
        "Azioni"
      ],
      "Please Confirm": [
        "Conferma"
      ],
      "Cancel": [
        "Annulla"
      ],
      "Submit": [
        "Invia"
      ],
      "Provision %s": [
        ""
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "Questa operazione potrebbe richiedere qualche istante poichè saranno annullati anche gli host, eventi e riporti"
      ],
      "Select location": [
        "Seleziona posizione"
      ],
      "Select organization": [
        "Seleziona organizzazione"
      ],
      "Discovered host: %s": [
        "Host trovati: %s"
      ],
      "Interfaces": [
        "Interfaccia"
      ],
      "Type": [
        "Tipo"
      ],
      "Identifier": [
        "Identificazione"
      ],
      "MAC address": [
        "Indirizzo MAC"
      ],
      "IP address": [
        "indirizzo IP"
      ],
      "Collapse All": [
        "Comprimi tutto"
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
        "Conteggio disco"
      ],
      "Disks size": [
        "Dimensione dischi"
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
        "Primario"
      ],
      "Locations": [
        "Posizioni"
      ],
      "Organizations": [
        "Organizzazioni"
      ],
      "Target host group for this rule with all properties set": [
        "Gruppo di host di destinazione per questa regola con tutte le proprietà impostate"
      ],
      "Hostname for provisioned hosts": [
        "Hostname per gli host con provisioning"
      ],
      "Hosts Limit": [
        "Limite host"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Numero di host massimo con provisioning con questa regola (0 = unlimited)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Priorità regola (valore intero più basso, priorità più alta)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Specifica il pattern del template per l'hostname di destinazione con la stessa sintassi dei template di provisioning (ERB)."
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
        "Modifica %s"
      ],
      "Discovery Rules": [
        "Regola per la scoperta"
      ],
      "Create Rule": [
        ""
      ],
      "DiscoveryRule|Name": [
        "Nome"
      ],
      "DiscoveryRule|Priority": [
        "Priorità"
      ],
      "DiscoveryRule|Query": [
        "Interrogazione"
      ],
      "Host Group": [
        "Gruppo di host"
      ],
      "Hosts/Limit": [
        ""
      ],
      "DiscoveryRule|Enabled": [
        "Abilitata"
      ],
      "New Discovery Rule": [
        "Nuova regola per la scoperta"
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
        "Dettagli:"
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
        ""
      ],
      "The default location to place discovered hosts in": [
        "La posizione predefinita nella quale posizionare gli host trovati"
      ],
      "Discovery organization": [
        ""
      ],
      "The default organization to place discovered hosts in": [
        "L'organizzazione predefinita nella quale posizionare gli host trovati"
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
        "Esegui automaticamente il provisioning degli host trovati, in base alle regole per il provisioning"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        ""
      ],
      "Hostname prefix": [
        ""
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "Il prefisso predefinito da usare per l'hostname, deve iniziare con una lettera"
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
        "Azione remota:"
      ],
      "Import Puppet classes": [
        "Importa classi Puppet"
      ],
      "Import facts": [
        "Importa gli eventi"
      ],
      "Action with sub plans": [
        ""
      ]
    }
  }
};