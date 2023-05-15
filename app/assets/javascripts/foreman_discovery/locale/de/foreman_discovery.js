 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['de'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Patrick Dolinic, 2021",
        "Language-Team": "German (http://www.transifex.com/foreman/foreman/language/de/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "de",
        "Plural-Forms": "nplurals=2; plural=(n != 1);",
        "lang": "de",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=2; plural=(n != 1);"
      },
      "List all discovered hosts": [
        "Alle entdeckten Hosts auflisten"
      ],
      "filter results": [
        "Ergebnisse filtern"
      ],
      "sort results": [
        "Ergebnisse sortieren"
      ],
      "paginate results": [
        "Ergebnisse nummerieren"
      ],
      "number of entries per request": [
        "Anzahl der Einträge pro Anfrage"
      ],
      "Show a discovered host": [
        "Entdeckten Host anzeigen"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "DHCP-Dateinamensoption (Standardmäßig Grub2/PXELinux)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Entdeckten Host zum Testen erstellen (verwenden Sie /Fakten zur Erstellung neuer Hosts)"
      ],
      "Provision a discovered host": [
        "Entdeckten Host bereitstellen"
      ],
      "required if host is managed and value is not inherited from host group": [
        "erforderlich, wenn der Host gemanagt und der Wert nicht von einer Hostgruppe vererbt ist"
      ],
      "not required if using a subnet with DHCP proxy": [
        "nicht erforderlich, wenn ein Subnetz mit DHCP-Proxy verwendet wird"
      ],
      "not required if it's a virtual machine": [
        "nicht erforderlich für eine virtuelle Maschine"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "erforderlich, wenn die Bereitstellung nicht image-basiert, der Host gemanagt und der Wert nicht von einer Hostgruppe vererbt ist"
      ],
      "required if host is managed and custom partition has not been defined": [
        "erforderlich, wenn der Host gemanagt und keine spezifische Partition definiert ist"
      ],
      "Host's owner type": [
        "Eigentümertyp des Hosts"
      ],
      "Host's parameters (array or indexed hash)": [
        "Hostparameter (Array oder indizierter Hash)"
      ],
      "Name of the parameter": [
        "Name des Parameters"
      ],
      "Parameter value": [
        "Parameterwert"
      ],
      "Type of value": [
        "Typ des Wertes"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID zum Tracken des Status der Orchestrierungsaufgaben, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "erforderlich, falls kein Wert von Hostgruppe geerbt wird oder es nicht das Standardpasswort in Einstellungen ist"
      ],
      "Delete a discovered host": [
        "Entdeckten Host löschen"
      ],
      "Upload facts for a host, creating the host if required": [
        "Fakten für einen Host hochladen mit Erstellung des Hosts, wenn erforderlich"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "Hash, der Fakten für den Host mit minimaler Anzahl an Fakten enthält: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (Beispiel für primäre Schnittstelle mit dem Namen eth0) "
      ],
      "Execute rules against a discovered host": [
        "Regeln auf einem entdeckten Host anwenden"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "Host %{host} wurde bereitgestellt mit Regel %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "%{host} kann nicht bereitgestellt werden: %{errors} "
      ],
      "No rule found for host %s": [
        "Keine Regel gefunden für Host %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Regeln auf allen kürzlich entdeckten Hosts anwenden"
      ],
      "Errors during auto provisioning: %s": [
        "Fehler bei automatischer Bereitstellung: %s"
      ],
      "No discovered hosts to provision": [
        "Keine entdeckten Hosts zur Bereitstellung"
      ],
      "%s discovered hosts were provisioned": [
        "%s entdeckte Hosts wurden bereitgestellt"
      ],
      "Refreshing the facts of a discovered host": [
        "Fakten eines entdeckten Hosts werden aktualisiert"
      ],
      "Rebooting a discovered host": [
        "Entdeckten Host neu starten"
      ],
      "Rebooting all discovered hosts": [
        "Alle entdeckten Hosts neu starten"
      ],
      "Discovered hosts are rebooting now": [
        "Entdeckte Hosts werden jetzt neu gestartet"
      ],
      "List all discovery rules": [
        "Alle Entdeckungsregeln auflisten"
      ],
      "Show a discovery rule": [
        "Entdeckungsregel anzeigen"
      ],
      "represents rule name shown to the users": [
        "repräsentiert den Regelnamen, der Benutzern angezeigt wird"
      ],
      "query to match discovered hosts for the particular rule": [
        "Abfrage zur Übereinstimmung mit entdeckten Hosts für die angegebene Regel"
      ],
      "the hostgroup that is used to auto provision a host": [
        "die Hostgruppe, die zur automatischen Bereitstellung eines Hosts verwendet wird"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "definiert ein Muster, nach dem einfach lesbare Hostnamen zu übereinstimmenden Hosts zugewiesen werden"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "ermöglicht die Begrenzung der maximal bereitgestellten Hosts pro Regel"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "ordnet die Regeln, niedrige Zahlen zuerst. Muss größer als Null sein"
      ],
      "flag is used for temporary shutdown of rules": [
        "Flag zur vorübergehenden Deaktivierung von Regeln"
      ],
      "location ID for provisioned hosts": [
        "Standort Kennung für bereitgestellte Hosts"
      ],
      "organization ID for provisioned hosts": [
        "Organisations-Kennung für bereitgestellte Hosts"
      ],
      "Create a discovery rule": [
        "Entdeckungsregel erstellen"
      ],
      "Update a rule": [
        "Regel aktualisieren"
      ],
      "Delete a rule": [
        "Regel löschen"
      ],
      "List all fact values of a given discovered host": [
        "Alle Faktwerte eines angegebenen entdeckten Hosts auflisten"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "Keine Entdeckungsregel gefunden, kein Host bereitgestellt (Berechtigungen prüfen)"
      ],
      "No hostgroup associated with rule '%s'": [
        " Der Regel '%s' ist keine Hostgruppe zugewiesen"
      ],
      "Errors during reboot: %s": [
        "Fehler bei Neustart: %s"
      ],
      "No discovered hosts to reboot": [
        "Keine entdeckten Hosts zum Neustarten"
      ],
      "Successfully provisioned %s": [
        "%s erfolgreich bereitgestellt"
      ],
      "Facts refreshed for %s": [
        "Fakten für %s erneuert"
      ],
      "Failed to refresh facts for %s": [
        "Fehler beim Aktualisieren von Fakten für %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "Fehler beim Aktualisieren der Fakten für %{hostname} mit Fehlermeldung %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "Host vom Typ %s kann nicht neu gestartet werden"
      ],
      "Rebooting host %s": [
        "Host %s wird neu gestartet"
      ],
      "Failed to reboot host %s": [
        "Fehler beim Neustart von Host %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Fehler beim Neustart von Host %{hostname} mit Fehlermeldung %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "Neustart von Hosts fehlgeschlagen mit Fehler %s"
      ],
      "Destroyed selected hosts": [
        "Ausgewählte Hosts gelöscht"
      ],
      "The following hosts were not deleted: %s": [
        "Die folgenden Hosts wurden nicht gelöscht: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Fehler bei automatischer Bereitstellung von Host %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Entdeckte Hosts, die jetzt bereitgestellt werden"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "Der erkannte Host wurde von einem unbekannten Subnetz gemeldet, die Kommunikation wird nicht über einen Proxy geleitet."
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "Erkannte Hosts, die von einem unbekannten Subnetz gemeldet wurden %s sind , die Kommunikation wird nicht über einen Proxy geleitet."
      ],
      "No hosts were found with that id or name": [
        "Keine Systeme mit dieser ID oder diesem Namen gefunden"
      ],
      "No hosts selected": [
        "Keine Hosts ausgewählt"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Fehler beim Auswählen der Hosts – %s"
      ],
      "Rule enabled": [
        "Regel aktiviert"
      ],
      "Rule disabled": [
        "Regel deaktiviert"
      ],
      "Auto Provision": [
        "Automatisch bereitstellen"
      ],
      "Refresh facts": [
        "Fakten aktualisieren"
      ],
      "Reboot": [
        "Neustart"
      ],
      "Back": [
        "Zurück"
      ],
      "Select Action": [
        "Aktion auswählen"
      ],
      "Delete %s?": [
        "%s löschen?"
      ],
      "Assign Organization": [
        "Organisation zuweisen"
      ],
      "Assign Location": [
        "Standort zuweisen"
      ],
      "Delete": [
        "Löschen"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - Die folgenden Hosts werden geändert"
      ],
      "N/A": [
        "N/A"
      ],
      "New in the last 24 hours": [
        "Neu in den letzten 24 Stunden"
      ],
      "Not reported in more than 7 days": [
        "Nicht berichtet in mehr als 7 Tagen"
      ],
      "Reported in the last 7 days": [
        "Berichtet in den letzten 7 Tagen"
      ],
      "Provision": [
        "Bereitstellen"
      ],
      "Discovered Hosts": [
        "Entdeckte Hosts"
      ],
      "Associated Hosts": [
        "Zugewiesene Hosts"
      ],
      "Disable": [
        "Deaktivieren"
      ],
      "Disable rule '%s'?": [
        "Regel '%s' deaktivieren?"
      ],
      "Enable": [
        "Aktivieren"
      ],
      "Enable rule '%s'?": [
        "Regel '%s' aktivieren?"
      ],
      "Clone": [
        "Klonen"
      ],
      "Delete rule '%s'?": [
        "Regel '%s' löschen?"
      ],
      "Invalid user type of %s was provided": [
        "Ungültiger Benutzertyp %s von wurde angegeben"
      ],
      "Discovered hosts summary": [
        "Zusammenfassung entdeckter Hosts"
      ],
      "can't contain white spaces.": [
        "darf keine Leerzeichen enthalten."
      ],
      "must start with a letter or ERB.": [
        "muss mit einem Buchstaben oder ERB beginnen."
      ],
      "must be present.": [
        "muss vorhanden sein."
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
        "Fakt + Prefix"
      ],
      "Random name": [
        "Zufälliger Name"
      ],
      "MAC-based name": [
        "Mac-basierter Name"
      ],
      "Invalid facts, must be a Hash": [
        "Ungültige Fakten, es muss sich um einen Hash handeln"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "Erwartetes discovery_fact '%s' fehlt, primäre Schnittstelle kann nicht gefunden und Hostname nicht eingestellt werden"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "Ungültige Fakten: Hash enthält keinen gültigen Wert für einen der Fakten in der Einstellung Discovery_Hostname: %s"
      ],
      "Facts could not be imported": [
        "Fakten konnten nicht importiert werden"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "Fakten konnten nicht vom Proxy %{url} abgerufen werden: %{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "Neustart auf %{name} (%{url}) nicht möglich: %{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "%{action} auf %{ips} kann nicht ausgeführt werden"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "Kexec kann auf %{name} (%{url}) nicht ausgeführt werden: %{msg}"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "Ungültiger Hostname: Konnte den Hostnamen nicht normalisieren"
      ],
      "Reloading kernel on %s": [
        "Kernel auf %s wird neu geladen"
      ],
      "Rebooting %s": [
        "%s wird neu gestartet"
      ],
      "Kexec template not associated with operating system": [
        "Kexec Vorlage ist nicht dem Betriebssystem zugeordnet"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "Kernel kexec URL ist ist ungültig: '%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "Init RAM kexec URL ist ungültig: '%s'"
      ],
      "Rebuild DNS for %s": [
        "DNS für %s neu bauen"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "Der Discovery-Faktenparser funktioniert nicht mit dem Nicht-Discovery-Host '%{host}'"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "Beim erkannten Host '%{host}' wurden alle NICs herausgefiltert, Filter: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "Kann primäre NIC mit %{mac} über '%{fact}' angegeben nicht finden, NIC-Filter: %{filter}"
      ],
      "Highlights": [
        "Hervorhebungen"
      ],
      "Storage": [
        "Speicher"
      ],
      "Hardware": [
        "Hardware"
      ],
      "Network": [
        "Netzwerk"
      ],
      "Software": [
        "Software"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "Erweitert"
      ],
      "IPAM must be configured for subnet '%s'": [
        "IPAM muss für Subnetz '%s' konfiguriert sein"
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
        "Image API gibt HTTP/%{code} mit '%{body} zurück"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "Image API Verarbeitungsfehler: %{msg} (HTTP/%{code}, Text: %{body})"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "Host %s wurde entdeckt"
      ],
      "Discovered Host": [
        "",
        ""
      ],
      "No discovered hosts available": [
        "Keine entdeckten Hosts verfügbar"
      ],
      "Host": [
        "Host"
      ],
      "Model": [
        "Modell"
      ],
      "CPUs": [
        "Anzahl der CPUs:"
      ],
      "Memory": [
        "Speicher"
      ],
      "Customize Host": [
        "Host anpassen"
      ],
      "Create Host": [
        "Host erstellen"
      ],
      "Select all items in this page": [
        "Alle Elemente auf dieser Seite auswählen"
      ],
      "items selected. Uncheck to Clear": [
        "Elemente ausgewählt. Zum Leeren abwählen"
      ],
      "Name": [
        "Name"
      ],
      "IP Address": [
        "IP-Adresse"
      ],
      "Disk Count": [
        "Festplattenanzahl"
      ],
      "Disks Size": [
        "Festplattengröße"
      ],
      "Location": [
        "Standort"
      ],
      "Organization": [
        "Organisation"
      ],
      "Subnet": [
        "Subnetz"
      ],
      "Last Facts Upload": [
        "Letzter Fakten-Upload"
      ],
      "Actions": [
        "Aktionen"
      ],
      "Please Confirm": [
        "Bitte bestätigen"
      ],
      "Cancel": [
        "Abbrechen"
      ],
      "Submit": [
        "Absenden"
      ],
      "Provision %s": [
        "Bereitstellung %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "Dieser Vorgang kann eine Weile dauern, da alle Hosts, Fakten und Berichte ebenfalls gelöscht werden"
      ],
      "Select location": [
        "Standort auswählen"
      ],
      "Select organization": [
        "Organisation auswählen"
      ],
      "Discovered host: %s": [
        "Entdeckter Host: %s"
      ],
      "Interfaces": [
        "Interfaces"
      ],
      "Type": [
        "Typ"
      ],
      "Identifier": [
        "Kennung"
      ],
      "MAC address": [
        "MAC-Adresse"
      ],
      "IP address": [
        "IP-Adresse"
      ],
      "Collapse All": [
        "Alle einklappen"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Zusammenfassungsbericht für entdeckte Hosts von Foreman"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b> Zusammenfassung entdeckter Hosts"
      ],
      "Summary from %{time} ago to %{now}": [
        "Zusammenfassung von %{time} bis %{now}"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Vom Foreman-Server unter %{foreman_url} entdeckte Hosts"
      ],
      "Disk count": [
        "Festplattenanzahl"
      ],
      "Disks size": [
        "Festplattengröße"
      ],
      "No discovered hosts for the selected period": [
        "Keine entdeckten Hosts für den ausgewählten Zeitraum"
      ],
      "Foreman discovered hosts summary": [
        "Foreman Zusammenfassung entdeckter Hosts"
      ],
      "No new discovered hosts for this period": [
        "Keine neu entdeckten Hosts für diesen Zeitraum"
      ],
      "Primary": [
        "Primär"
      ],
      "Locations": [
        "Standorte"
      ],
      "Organizations": [
        "Organisationen"
      ],
      "Target host group for this rule with all properties set": [
        "Ziel-Hostgruppe für diese Regel mit allen Eigenschaften gesetzt"
      ],
      "Hostname for provisioned hosts": [
        "Hostname für bereitgestellte Hosts"
      ],
      "Hosts Limit": [
        "Hosts-Limit"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Höchstanzahl von Hosts, die mit dieser Regel bereitgestellt werden (0 = unbegrenzt)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Regelpriorität (niedriger Wert bedeutet hohe Priorität)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Vorlagenmuster des Ziel-Hostnamens in derselben Syntax angeben wie in Bereitstellungsvorlagen (ERB)."
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "Domäne wird automatisch angehängt. Ein Hostname basierend auf der MAC-Adresse wird genutzt, wenn das Feld leer ist."
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "Zusätzlich zum @host-Attribut steht die Funktion rand für zufällige ganze Zahlen zur Verfügung. Beispiele:"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "Stellen Sie beim Erstellen von Hostnamenmustern sicher, dass die resultierenden Hostnamen eindeutig sind."
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "Hostnamen dürfen nicht mit Zahlen beginnen. Ein guter Ansatz besteht darin, eindeutige Informationen zu verwenden, die von facter bereitgestellt werden (MAC-Adresse, BIOS oder serielle ID)."
      ],
      "Clone %s": [
        "%s klonen"
      ],
      "Edit %s": [
        "%s bearbeiten"
      ],
      "Discovery Rules": [
        "Entdeckungsregeln"
      ],
      "Create Rule": [
        "Regel erstellen"
      ],
      "DiscoveryRule|Name": [
        "Name"
      ],
      "DiscoveryRule|Priority": [
        "Priorität"
      ],
      "DiscoveryRule|Query": [
        "Abfrage"
      ],
      "Host Group": [
        "Hostgruppe"
      ],
      "Hosts/Limit": [
        "Hosts/Limit"
      ],
      "DiscoveryRule|Enabled": [
        "Aktiviert"
      ],
      "New Discovery Rule": [
        "Neue Entdeckungsregel"
      ],
      "Discovered Rules": [
        "Entdeckte Regeln"
      ],
      "A summary of discovered hosts": [
        "Eine Zusammenfassung der entdeckten Hosts"
      ],
      "New hosts": [
        "Neue Hosts"
      ],
      "One or more hosts have been discovered": [
        "Einer oder mehrere Hosts wurden entdeckt"
      ],
      "Details": [
        "Details"
      ],
      "Hosts": [
        "Hosts"
      ],
      "Error message goes here": [
        "Fehlermeldung kommt hier"
      ],
      "Discovery": [
        "Entdecken"
      ],
      "Discovery location": [
        "Entdeckungsort"
      ],
      "The default location to place discovered hosts in": [
        "Standard-Standort, in den entdeckte Hosts platziert werden"
      ],
      "Discovery organization": [
        "Entdeckungsorganisation"
      ],
      "The default organization to place discovered hosts in": [
        "Standard-Organisation, in die entdeckte Hosts platziert werden"
      ],
      "Interface fact": [
        "Schnittstellenfakt"
      ],
      "Fact name to use for primary interface detection": [
        "Fakt Name zur Verwendung bei der Erkennung der primären Schnittstelle"
      ],
      "Create bond interfaces": [
        "Bondschnittstellen erstellen"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "Automatische Bond-Schnittstelle (wenn eine andere Schnittstelle im selben VLAN über LLDP erkannt wird)"
      ],
      "Clean all facts": [
        "Alle Fakten löschen"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "Alle berichteten Fakten während der Bereitstellung löschen (ausgenommen Entdeckungsfakten)"
      ],
      "Hostname facts": [
        "Hostnamenfakten"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "Automatische Bereitstellung"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "Neu entdeckte Hosts automatisch bereitstellen gemäß Bereitstellungsregeln"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "Automatischer Reboot oder kexec endeckter Hosts während der Bereitstellung"
      ],
      "Hostname prefix": [
        "Hostnamenpräfix"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "Das Standard-Präfix zum Verwenden für den Hostnamen, muss mit einem Buchstaben beginnen"
      ],
      "Fact columns": [
        "Faktspalten"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "Hervorgehobene Fakten"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "Regex zum Organisieren von Fakten für den Abschnitt Highlights - z.B. ^(abc|cde)$"
      ],
      "Storage facts": [
        "Speicherfakten"
      ],
      "Regex to organize facts for storage section": [
        "Regex zur Faktensortierung im Speicher-Bereich"
      ],
      "Software facts": [
        "Softwarefakten"
      ],
      "Regex to organize facts for software section": [
        "Regex zur Faktensortierung im Software-Bereich"
      ],
      "Hardware facts": [
        "Hardwarefakten"
      ],
      "Regex to organize facts for hardware section": [
        "Regex zur Faktensortierung im Hardware-Bereich"
      ],
      "Network facts": [
        "Netzwerkfakten"
      ],
      "Regex to organize facts for network section": [
        "Regex zur Faktensortierung im Netzwerk-Bereich"
      ],
      "IPMI facts": [
        "IPMI-Fakten"
      ],
      "Regex to organize facts for ipmi section": [
        "Regex zur Faktensortierung im IMPI-Bereich"
      ],
      "Lock PXE": [
        "PXE sperren"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "PXE-Konfiguration automatisch erzeugen, um einen neu entdeckten Host zu einer Entdeckung anzuheften"
      ],
      "Locked PXELinux template name": [
        "Gesperrter PXELinux-Vorlagenname"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "PXELinux-Vorlage, die beim Anheften eines Hosts an die Erkennung verwendet werden soll"
      ],
      "Locked PXEGrub template name": [
        "Gesperrter PXEGrub-Vorlagenname"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "PXEGrub-Vorlage, die beim Anheften eines Hosts an die Erkennung verwendet werden soll"
      ],
      "Locked PXEGrub2 template name": [
        "Gesperrter PXEGrub2-Vorlagenname"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "PXEGrub2-Vorlage, die beim Anheften eines Hosts an Discovery verwendet werden soll"
      ],
      "Force DNS": [
        "DNS erzwingen"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "Erzwingen Sie die Erstellung von DNS-Einträgen bei der Bereitstellung des erkannten Hosts"
      ],
      "Error on existing NIC": [
        "Fehler auf existierenden NIC"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "Nicht zulassen, dass vorhandene verwaltete Hosts gefunden werden, die dem MAC einer Provisioning-NIC entsprechen (Fehler werden frühzeitig behoben)"
      ],
      "Type of name generator": [
        "Typ des Namensgenerators"
      ],
      "Discovery hostname naming pattern": [
        "Benennungsmuster für Discovery-Hostnamen"
      ],
      "Prefer IPv6": [
        "IPv6 bevorzugen"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "Bevorzugen Sie IPv6 gegenüber IPv4, wenn Sie erkannte Knoten aufrufen"
      ],
      "Discovery Proxy": [
        "Discovery-Proxy"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "Discovery Proxy zur Verwendung innerhalb dieses Subnetzes zum Verwalten der Verbindung zu erkannten Hosts"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "ID des Discovery-Proxys, der in diesem Subnetz zum Verwalten der Verbindung zu erkannten Hosts verwendet werden soll"
      ],
      "For more information please see ": [
        "Weitere Informationen finden Sie unter"
      ],
      "documentation": [
        "Dokumentation"
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
        "Entfernte Aktion:"
      ],
      "Import Puppet classes": [
        "Puppet-Klassen importieren"
      ],
      "Import facts": [
        "Fakten importieren"
      ],
      "Action with sub plans": [
        "Aktion mit Unterplänen"
      ]
    }
  }
};