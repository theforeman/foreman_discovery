 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['ka'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "FULL NAME <EMAIL@ADDRESS>",
        "Language-Team": "Georgian (http://www.transifex.com/foreman/foreman/language/ka/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "ka",
        "Plural-Forms": "nplurals=2; plural=(n!=1);",
        "lang": "ka",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=2; plural=(n!=1);"
      },
      "List all discovered hosts": [
        "ყველა აღმოჩენილი ჰოსტის სია"
      ],
      "filter results": [
        "ფილტრის შედეგები"
      ],
      "sort results": [
        "შედეგების დალაგება"
      ],
      "paginate results": [
        "გვერდების დანომრვის შედეგები"
      ],
      "number of entries per request": [
        "ელემენტების რაოდენობა თითოეულ მოთხოვნაში"
      ],
      "Show a discovered host": [
        "აღმოჩენილი ჰოსის ჩვენება"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "DHCP-ის ფაილის სახელის პარამეტრი (ნაგულისხმებია Grub2 ან PXELinux)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "აღმოჩენილი ჰოსტის სატესტოდ შექმნა (ახალი ჰოსტების შესაქმნელად გამოიყენეთ /facts)"
      ],
      "Provision a discovered host": [
        "აღმოჩენილი ჰოსტის სამუშაოდ მომზადება"
      ],
      "required if host is managed and value is not inherited from host group": [
        "საჭიროა, თუ ჰოსტის მართულია და მნიშვნელობა მემკვიდრეობით არაა გადმოცემული ჰოსტების ჯგუფიდან"
      ],
      "not required if using a subnet with DHCP proxy": [
        "dhcp პროქსის მქოლე ქვექსელის გამოყენებისას საჭირო არაა"
      ],
      "not required if it's a virtual machine": [
        "საჭირო არაა, თუ ის ვირტუალური მანქანაა"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "საჭიროა, თუ ჰოსტი ასლით არ მომზადებულა სამუშაოდ, მართულია და მნიშვნელობა მემკვიდრეობით არაა გადმოცემული ჰოსტების ჯგუფიდან"
      ],
      "required if host is managed and custom partition has not been defined": [
        "საჭიროა, თუ ჰოსტი იმართება და მორგებული დანაყოფი არ არის განსაზღვრული"
      ],
      "Host's owner type": [
        "ჰოსტის მფლობელის ტიპი"
      ],
      "Host's parameters (array or indexed hash)": [
        "ჰოსტის პარამეტრები (მასივი ან ინდექსირებული ჰეშ)"
      ],
      "Name of the parameter": [
        "პარამეტრის სახელი"
      ],
      "Parameter value": [
        "პარამეტრის მნიშვნელობა"
      ],
      "Type of value": [
        "მნიშვნელობის ტიპი"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID ორკესტრის ამოცანების სტატუსის თვალყურის დევნებისთვის, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        ""
      ],
      "Delete a discovered host": [
        "აღმოჩენილი ჰოსის წაშლა"
      ],
      "Upload facts for a host, creating the host if required": [
        "ჰოსტის ფაქტების ატვირთვას საჭიროების შემთხვევაში ჰოსტის შექმნაც შეუძლია"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        ""
      ],
      "Execute rules against a discovered host": [
        ""
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "ჰოსტი %{host} სამუშაოდ მომზადდა წესებით %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "სამუშაოდ მომზადების შეცდომა %{host}: %{errors}"
      ],
      "No rule found for host %s": [
        "ჰოსტისთვის წესი ნაპოვნი არაა: %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "ამჟამად აღმოჩენილ ყველა ჰოსტზე წესების გადატარება"
      ],
      "Errors during auto provisioning: %s": [
        "შეცდომა სამუშაოდ ავტომატურად მომზადებისას: %s"
      ],
      "No discovered hosts to provision": [
        "სამუშაოდ მოსამზადებელი ჰოსტები აღმოჩენილი არაა"
      ],
      "%s discovered hosts were provisioned": [
        "%s აღმოჩენილი ჰოსტი სამუშაოდ მომზადდა"
      ],
      "Refreshing the facts of a discovered host": [
        "აღმოჩენილი ჰოსტების ფაქტების განახლება"
      ],
      "Rebooting a discovered host": [
        "აღმოჩენილი ჰოსტის გადატვირთვა"
      ],
      "Rebooting all discovered hosts": [
        "აღმოჩენილი ჰოსტების გადატვირთვა"
      ],
      "Discovered hosts are rebooting now": [
        "მიმდინარეობს აღმოჩენილი ჰოსტების გადატვირთვა"
      ],
      "List all discovery rules": [
        "აღმოჩენის ყველა წესის სია"
      ],
      "Show a discovery rule": [
        "აღმოჩენის წესების ჩვენება"
      ],
      "represents rule name shown to the users": [
        "წარმოადგენს წესის სახელს, რომელსაც მომხმარებლები ხედავენ"
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
        "სამუშაოდ მომზადებული ჰოსტების მდებარეობის ID"
      ],
      "organization ID for provisioned hosts": [
        "სამუშაოდ მომზადებული ჰოსტების ორგანიზაციის"
      ],
      "Create a discovery rule": [
        "აღმოჩენის წესის ჩვენება"
      ],
      "Update a rule": [
        "წესის განახლება"
      ],
      "Delete a rule": [
        "წესის წაშლა"
      ],
      "List all fact values of a given discovered host": [
        "მითითებული აღმოჩენილი ჰოსტის ფაქტის ყველა მნიშვნელობის სია"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        ""
      ],
      "No hostgroup associated with rule '%s'": [
        ""
      ],
      "Errors during reboot: %s": [
        "შეცდომები გადატვირთვისას: %s"
      ],
      "No discovered hosts to reboot": [
        "აღმოჩენილი ჰოსტებიდან გადასატვირთი არცერთი არაა"
      ],
      "Successfully provisioned %s": [
        "%s წარმატებით მომზადდა სამუშაოდ"
      ],
      "Facts refreshed for %s": [
        "%s-ის ფაქტები განახლებულია"
      ],
      "Failed to refresh facts for %s": [
        "%s-ის ფაქტების განახლების შეცდომა"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        ""
      ],
      "Host of type %s can not be rebooted": [
        "ჰოსტის ამ ტიპის (%s) გადატვირთვა შეუძლებელია"
      ],
      "Rebooting host %s": [
        "%s-ის გადატვირთვა"
      ],
      "Failed to reboot host %s": [
        "ჰოსტის გადატვირთვის შეცდომა: %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "ჰოსტის %{hostname} გადატვირთვის შეცდომა: %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "შეცდომები ჰოსტის გადატვირთვისას: %s"
      ],
      "Destroyed selected hosts": [
        "მონიშნული ჰოსტები განადგურებულია"
      ],
      "The following hosts were not deleted: %s": [
        "ჰოსტები არ წაშლილა: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "ჰოსტის სამუშაოდ მომზადების შეცდომა %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "მიმდინარეობს აღმოჩენილი ჰოსტების სამუშაოდ მომზადება"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        "მითითებული ID-ით ან სახელით ჰოსტები ნაპოვნი არაა"
      ],
      "No hosts selected": [
        "ჰოსტები მონიშნული არაა"
      ],
      "Something went wrong while selecting hosts - %s": [
        "შეცდომა ჰოსტების მონიშვნისას - %s"
      ],
      "Rule enabled": [
        "წესი ჩართულია"
      ],
      "Rule disabled": [
        "წესი გამორთულია"
      ],
      "Auto Provision": [
        "მუშაობისთვის ავტომატური მომზადება"
      ],
      "Refresh facts": [
        "ფაქტების განახლება"
      ],
      "Reboot": [
        "გადატვირთვა"
      ],
      "Back": [
        "უკან"
      ],
      "Select Action": [
        "აირჩიეთ ქმედება"
      ],
      "Delete %s?": [
        "წავშალო \\\"%s\\\"?"
      ],
      "Assign Organization": [
        "ორგანიზაციის მინიჭება"
      ],
      "Assign Location": [
        "მდებარეობის მინიჭება"
      ],
      "Delete": [
        "წაშლა"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - ეს ჰოსტები შეიცვლება"
      ],
      "N/A": [
        "N/A"
      ],
      "New in the last 24 hours": [
        "ახახლი ბოლო 24 საათში"
      ],
      "Not reported in more than 7 days": [
        "ბოლო 7 დღეა, კავშირი არ ყოფილა"
      ],
      "Reported in the last 7 days": [
        "შემდგარი კავშირი ბოლო 7 დღის განმავლობაში"
      ],
      "Provision": [
        "მუშაობისთვის მომზადება"
      ],
      "Discovered Hosts": [
        "აღმოჩენილი ჰოსტები"
      ],
      "Associated Hosts": [
        "შესაბამისი ჰოსტები"
      ],
      "Disable": [
        "გამორთვა"
      ],
      "Disable rule '%s'?": [
        "გავთიშო წესი '%s'?"
      ],
      "Enable": [
        "ჩართვა"
      ],
      "Enable rule '%s'?": [
        "ჩავრთო წესი '%s'?"
      ],
      "Clone": [
        "კლონირება"
      ],
      "Delete rule '%s'?": [
        "წავშალო წესი '%s'?"
      ],
      "Invalid user type of %s was provided": [
        "მომხმარებლის მითითებული ტიპი არასწორია: %s"
      ],
      "Discovered hosts summary": [
        "აღმოჩენილი ჰოსტების მიმოხილვა"
      ],
      "can't contain white spaces.": [
        "არ შეიძლება შეიცავდეს თეთრ გამოტოვებებს."
      ],
      "must start with a letter or ERB.": [
        "უნდა იწყებოდეს სიმბოლოთი ან ERB-ით."
      ],
      "must be present.": [
        "უნდა არსებობდეს."
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
        "ფაქტი + პრეფიქსი"
      ],
      "Random name": [
        "შემთხვევითი სახელი"
      ],
      "MAC-based name": [
        "MAC-ზე დაფუძნებული სახელი"
      ],
      "Invalid facts, must be a Hash": [
        "არასწორი ფაქტები. უნდა წარმოადგენდნენ ჰეშს"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        ""
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        ""
      ],
      "Facts could not be imported": [
        "ფაქტების შემოტანა შეუძლებელია"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "პროქსიდან ფაქტების მიღების შეცდომა %{url}: %{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "გადატვირთვის შეცდომა %{name} (%{url}): %{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "შესრულების შეცდომა %{action} %{ips}-ზე"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        ""
      ],
      "Invalid hostname: Could not normalize the hostname": [
        ""
      ],
      "Reloading kernel on %s": [
        "ბირთვის გადატვირთვა %s-ზე"
      ],
      "Rebooting %s": [
        "%s-ის გადატვირთვა"
      ],
      "Kexec template not associated with operating system": [
        ""
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "ბირთვის kexec URL არასწორია: %s"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "საწყისი RAM kexec-ის URL არასწორია: \\\"%s\\\""
      ],
      "Rebuild DNS for %s": [
        "%s-ის DNS-ის თავიდან აგება"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        ""
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "აღმოჩენილი ჰოსტის '%{host}' ყველა ინტერფეისი გაიფილტრა. ფილტრი: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        ""
      ],
      "Highlights": [
        "განათება"
      ],
      "Storage": [
        "საცავი"
      ],
      "Hardware": [
        "აპარატურა"
      ],
      "Network": [
        "ქსელი"
      ],
      "Software": [
        "პროგრამები"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "სხვადასხვა"
      ],
      "IPAM must be configured for subnet '%s'": [
        "ქვექსელისთვის '%s' საჭიროა IPAM-ის მორგება"
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
        "ასლების API-მა დააბრუნა HTTP/%{code} შემცველობით '%{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "ასლების API-ის დამუშავების შეცდომა: %{msg} (HTTP/%{code}, შემცველობით: %{body})"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "ჰოსტი აღმოჩენილია: %s"
      ],
      "Discovered Host": [
        "აღმოჩენილი ჰოსტი",
        "აღმოჩენილი ჰოსტი"
      ],
      "No discovered hosts available": [
        "აღმოჩენილი ჰოსტები მიუწვდომელია"
      ],
      "Host": [
        "ჰოსტი"
      ],
      "Model": [
        "მოდელი"
      ],
      "CPUs": [
        "CPU"
      ],
      "Memory": [
        "მეხსიერება"
      ],
      "Customize Host": [
        "ჰოსტის მორგება"
      ],
      "Create Host": [
        "ჰოსტის შექმნა"
      ],
      "Select all items in this page": [
        "ამ გვერდზე ყველა ჩანაწერის მონიშვნა"
      ],
      "items selected. Uncheck to Clear": [
        "ჩანაწერები მონიშნულია. გასასუფთავებლად მოხსენით მონიშვნა"
      ],
      "Name": [
        "სახელი"
      ],
      "IP Address": [
        "IP მისამართი"
      ],
      "Disk Count": [
        "დისკების რაოდენობა"
      ],
      "Disks Size": [
        "დისკების ზომები"
      ],
      "Location": [
        "მდებარეობა"
      ],
      "Organization": [
        "ორგანიზაცია"
      ],
      "Subnet": [
        "ქვექსელი"
      ],
      "Last Facts Upload": [
        "ბოლოს ატვირთული ფაქტები"
      ],
      "Actions": [
        "ქმედებები"
      ],
      "Please Confirm": [
        "დაადასტურეთ"
      ],
      "Cancel": [
        "გაუქმება"
      ],
      "Submit": [
        "გაგზავნა"
      ],
      "Provision %s": [
        "მუშაობისთვის მომზადება: %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        ""
      ],
      "Select location": [
        "აირჩიეთ მდებარეობა"
      ],
      "Select organization": [
        "აირჩიეთ ორგანიზაცია"
      ],
      "Discovered host: %s": [
        "აღმოჩენილი ჰოსტი:%s"
      ],
      "Interfaces": [
        "ინტერფეისები"
      ],
      "Type": [
        "ტიპი"
      ],
      "Identifier": [
        "იდენტიფიკატორი"
      ],
      "MAC address": [
        "MAC მისამართი"
      ],
      "IP address": [
        "IP მისამართი"
      ],
      "Collapse All": [
        "ყველას ჩაკეცვა"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Foreman-ით აღმოჩენილი აღმოჩენილი ჰოსტების მიმოხილვა"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b> აღმოჩენილი ჰოსტების მიმოხილვა"
      ],
      "Summary from %{time} ago to %{now}": [
        "ანგარიში %{time} -ის წინ %{now}-მდე"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        ""
      ],
      "Disk count": [
        "დისკების რაოდენობა"
      ],
      "Disks size": [
        "დისკების ზომები"
      ],
      "No discovered hosts for the selected period": [
        "ამ პერიოდში ახალი ჰოსტები არ აღმოჩენილა"
      ],
      "Foreman discovered hosts summary": [
        "Foreman-ით აღმოჩენილი აღმოჩენილი ჰოსტების მიმოხილვა"
      ],
      "No new discovered hosts for this period": [
        "ამ პერიოდში ახალი ჰოსტები არ აღმოჩენილა"
      ],
      "Primary": [
        "ძირითადი"
      ],
      "Locations": [
        "მდებარეობები"
      ],
      "Organizations": [
        "ორგანიზაციები"
      ],
      "Target host group for this rule with all properties set": [
        ""
      ],
      "Hostname for provisioned hosts": [
        "სამუშაოდ მომზადებული ჰოსტების სახელები"
      ],
      "Hosts Limit": [
        "ჰოსტების ლიმიტი"
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
        "%s-ის კლონი"
      ],
      "Edit %s": [
        "%s-ის ჩასწორება"
      ],
      "Discovery Rules": [
        "აღმოჩენის წესები"
      ],
      "Create Rule": [
        "წესის შექმნა"
      ],
      "DiscoveryRule|Name": [
        "აღმოჩენისწესი|ახელი"
      ],
      "DiscoveryRule|Priority": [
        "აღმოჩენისწესი|პრიორიტეტი"
      ],
      "DiscoveryRule|Query": [
        "აღმოჩენისწესი|მოთხოვნა"
      ],
      "Host Group": [
        "ჰოსტების ჯგუფი"
      ],
      "Hosts/Limit": [
        "ჰოსტები/ლიმიტი"
      ],
      "DiscoveryRule|Enabled": [
        "აღმოჩენისწესი|ჩართული"
      ],
      "New Discovery Rule": [
        "აღმოჩენის ახალი წესი"
      ],
      "Discovered Rules": [
        "აღმოჩენილი წესები"
      ],
      "A summary of discovered hosts": [
        "აღმოჩენილი ჰოსტების მიმოხილვა"
      ],
      "New hosts": [
        "ახალი ჰოსტები"
      ],
      "One or more hosts have been discovered": [
        "აღმოჩენილია ერთი ან მეტი ჰოსტი"
      ],
      "Details": [
        "დეტალები"
      ],
      "Hosts": [
        "ჰოსტები"
      ],
      "Error message goes here": [
        "აქ შეცდომები გამოჩნდება"
      ],
      "Discovery": [
        "აღმოჩენა"
      ],
      "Discovery location": [
        "აღმოჩენის მდებარეობა"
      ],
      "The default location to place discovered hosts in": [
        ""
      ],
      "Discovery organization": [
        "ორგანიზაციის აღმოჩენა"
      ],
      "The default organization to place discovered hosts in": [
        ""
      ],
      "Interface fact": [
        "ინტერფეისის ფაქტი"
      ],
      "Fact name to use for primary interface detection": [
        ""
      ],
      "Create bond interfaces": [
        "ინტერფეისების აგრეგაციის შექმნა"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        ""
      ],
      "Clean all facts": [
        "ყველა ფაქტის გასუფთავება"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        ""
      ],
      "Hostname facts": [
        "ჰოსტის სახელის ფაქტები"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "მუშაობისთვის ავტომატურად მომზადება"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        ""
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        ""
      ],
      "Hostname prefix": [
        "ჰოსტის სახელის პრეფიქსი"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        ""
      ],
      "Fact columns": [
        "ფაქტის სვეტები"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "გამოკვეთილი ფაქტები"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        ""
      ],
      "Storage facts": [
        "საცავის ფაქტები"
      ],
      "Regex to organize facts for storage section": [
        "რეგულარული გამოსახულება საცავის ფაქტების დასალაგებლად"
      ],
      "Software facts": [
        "პროგრამების ფაქტები"
      ],
      "Regex to organize facts for software section": [
        "რეგულარული გამოსახულება პროგრამების ფაქტების დასალაგებლად"
      ],
      "Hardware facts": [
        "აპარატურის ფაქტები"
      ],
      "Regex to organize facts for hardware section": [
        "რეგულარული გამოსახულება აპარატურის ფაქტების დასალაგებლად"
      ],
      "Network facts": [
        "ქსელის ფაქტები"
      ],
      "Regex to organize facts for network section": [
        "რეგულარული გამოსახულება ქსელის ფაქტების დასალაგებლად"
      ],
      "IPMI facts": [
        "IPMI ფაქტები"
      ],
      "Regex to organize facts for ipmi section": [
        "რეგულარული გამოსახულება IPMI-ის ფაქტების დასალაგებლად"
      ],
      "Lock PXE": [
        "PXE-ის ჩაკეტვა"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        ""
      ],
      "Locked PXELinux template name": [
        "PXELinux-ის დაბლოკილი შაბლონის სახელი"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "PXELinux-ის შაბლონი, რომლითაც აღმოჩენილი ჰოსტების მიჭიკარტება ხდება"
      ],
      "Locked PXEGrub template name": [
        "PXEGrub-ის დაბლოკილი შაბლონის სახელი"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "PXEGrub-ის შაბლონი, რომლითაც აღმოჩენილი ჰოსტების მიჭიკარტება ხდება"
      ],
      "Locked PXEGrub2 template name": [
        "PXEGrub2-ის დაბლოკილი შაბლონის სახელი"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "PXEGrub2-ის შაბლონი, რომლითაც აღმოჩენილი ჰოსტების მიჭიკარტება ხდება"
      ],
      "Force DNS": [
        "ნაძალადევი DNS"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        ""
      ],
      "Error on existing NIC": [
        "შეცდომა არსებულ NIC-ზე"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        ""
      ],
      "Type of name generator": [
        "სახელის გენერატორის ტიპი"
      ],
      "Discovery hostname naming pattern": [
        "აღმოჩენილი ჰოსტების სახელების დარქმევის შაბლონი"
      ],
      "Prefer IPv6": [
        "IPv6-ის უპირატესობა"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "აღმოჩენილ კვანძებზე IPv6-სთვის მეტი პრიორიტეტის მიცემა"
      ],
      "Discovery Proxy": [
        "აღმოჩენის პროქსი"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        ""
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        ""
      ],
      "For more information please see ": [
        "მეტი ინფორმაციისთვის იხილეთ "
      ],
      "documentation": [
        "დოკუმენტაცია"
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
        "დაშორებული ქმედება:"
      ],
      "Import Puppet classes": [
        "Puppet-ის კლასების შემოტანა"
      ],
      "Import facts": [
        "ფაქტების შემოტანა"
      ],
      "Action with sub plans": [
        "ქმედება ქვე-გეგმებით"
      ]
    }
  }
};