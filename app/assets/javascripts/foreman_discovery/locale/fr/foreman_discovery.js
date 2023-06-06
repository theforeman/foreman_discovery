 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['fr'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Baptiste Agasse <baptiste.agasse@gmail.com>, 2018-2019",
        "Language-Team": "French (http://www.transifex.com/foreman/foreman/language/fr/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "fr",
        "Plural-Forms": "nplurals=3; plural=(n == 0 || n == 1) ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;",
        "lang": "fr",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=3; plural=(n == 0 || n == 1) ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;"
      },
      "List all discovered hosts": [
        "Afficher tous les hôtes détectés"
      ],
      "filter results": [
        "filtrer les résultats"
      ],
      "sort results": [
        "trier les résultats"
      ],
      "paginate results": [
        "paginer les résultats"
      ],
      "number of entries per request": [
        "nombre d'entrées par requête"
      ],
      "Show a discovered host": [
        "Afficher un hôte détecté"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "Option nom de fichier DHCP (Grub2 ou PXELinux par défaut)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Créer un hôte détecté pour le test (utiliser /facts pour créer des hôtes)"
      ],
      "Provision a discovered host": [
        "Provisionner un hôte détecté"
      ],
      "required if host is managed and value is not inherited from host group": [
        "requis si l'hôte est géré et la valeur n'est pas héritée d'un groupe d'hôtes"
      ],
      "not required if using a subnet with DHCP proxy": [
        "n'est pas requis s'il s'agit d'un sous-réseau avec un proxy DHCP"
      ],
      "not required if it's a virtual machine": [
        "non requis s'il s'agit d'une machine virtuelle"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "requis si le provisioning n'est pas basé sur une image , que l'hôte est géré et que la valeur n'est pas héritée d'un groupe d'hôtes"
      ],
      "required if host is managed and custom partition has not been defined": [
        "requis si l'hôte est géré et possède une partition spécifique qui n'a pas été définie"
      ],
      "Host's owner type": [
        "Type de propriétaire de l'hôte"
      ],
      "Host's parameters (array or indexed hash)": [
        "Paramètres de l'hôte (tableau ou hachage indexé)"
      ],
      "Name of the parameter": [
        "Nom du paramètre"
      ],
      "Parameter value": [
        "Valeur du paramètre"
      ],
      "Type of value": [
        "Type de valeur"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID pour surveiller l'état des tâches d'orchestration : GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "requis si la valeur n'est pas héritée d'un groupe d'hôtes ou du mot de passe par défaut défini dans les paramètres"
      ],
      "Delete a discovered host": [
        "Supprimer un hôte détecté"
      ],
      "Upload facts for a host, creating the host if required": [
        "Télécharge les facts d'un hôte, créé l'hôte si besoin"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "hachage contenant les facts de l'hôte avec un ensemble minimal de facts : discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (exemple si l'interface principale s'appelle eth0)"
      ],
      "Execute rules against a discovered host": [
        "Exécuter les règles sur un hôte détecté"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "L'hôte %{host} a été provisionné avec la règle %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "Impossible à provisionner %{host} : %{errors}"
      ],
      "No rule found for host %s": [
        "Aucune règle trouvée pour l’hôte %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Exécuter les règles sur tous les hôtes actuellement détectés"
      ],
      "Errors during auto provisioning: %s": [
        "Erreurs lors du provisioning automatique : %s"
      ],
      "No discovered hosts to provision": [
        "Aucun hôte détecté à provisionner"
      ],
      "%s discovered hosts were provisioned": [
        "%s hôtes détectés ont été provisionnés"
      ],
      "Refreshing the facts of a discovered host": [
        "Actualisation des facts d'un hôte détecté"
      ],
      "Rebooting a discovered host": [
        "Redémarrage d'un hôte détecté"
      ],
      "Rebooting all discovered hosts": [
        "Redémarrage de tous les hôtes détectés"
      ],
      "Discovered hosts are rebooting now": [
        "Les hôtes détectés sont redémarrés maintenant"
      ],
      "List all discovery rules": [
        "Répertorier toutes les règles de détection"
      ],
      "Show a discovery rule": [
        "Afficher une règle de détection"
      ],
      "represents rule name shown to the users": [
        "représente le nom de règle affiché aux utilisateurs"
      ],
      "query to match discovered hosts for the particular rule": [
        "requête à faire correspondre aux hôtes détectés pour la règle en question"
      ],
      "the hostgroup that is used to auto provision a host": [
        "groupe d'hôtes utilisé pour provisionner automatiquement un hôte"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "définit un modèle pour attribuer les noms d'hôte lisibles par l'homme aux hôtes correspondants"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "permet de limiter le nombre maximal d'hôtes provisionnés par règle"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "range les règles par ordre croissant. Doit être supérieur à zéro"
      ],
      "flag is used for temporary shutdown of rules": [
        "indicateur utilisé pour l'arrêt temporaire des règles"
      ],
      "location ID for provisioned hosts": [
        "ID d'emplacement pour les hôtes mis en service"
      ],
      "organization ID for provisioned hosts": [
        "ID d'organisation pour les hôtes mis en service"
      ],
      "Create a discovery rule": [
        "Créer une règle de détection"
      ],
      "Update a rule": [
        "Mettre à jour une règle"
      ],
      "Delete a rule": [
        "Supprimer une règle"
      ],
      "List all fact values of a given discovered host": [
        "Afficher toutes les valeurs des facts d'un hôte détecté donné"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "Impossible de trouver une règle de détection, aucun hôte fourni (vérifier les autorisations)"
      ],
      "No hostgroup associated with rule '%s'": [
        "Aucun groupe d'hôtes associé à la règle '%s'"
      ],
      "Errors during reboot: %s": [
        "Erreurs lors du redémarrage : %s"
      ],
      "No discovered hosts to reboot": [
        "Aucun hôte détecté pour le redémarrage"
      ],
      "Successfully provisioned %s": [
        "Provisioning réussi de %s"
      ],
      "Facts refreshed for %s": [
        "Facts rafraîchis pour %s"
      ],
      "Failed to refresh facts for %s": [
        "Échec de rafraîchissement des facts pour %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "Impossible de rafraîchir les données pour %{hostname} avec l'erreur %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "Impossible de redémarrer l'hôte de type %s"
      ],
      "Rebooting host %s": [
        "Redémarrage de l'hôte %s"
      ],
      "Failed to reboot host %s": [
        "Échec du redémarrage de l'hôte %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Échec du redémarrage de l'hôte %{hostname} avec l'erreur %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "Échec du redémarrage des hôtes avec l'erreur %s"
      ],
      "Destroyed selected hosts": [
        "Hôtes sélectionnés détruits"
      ],
      "The following hosts were not deleted: %s": [
        "Les hôtes suivants n'ont pas été supprimés : %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Échec de l'approvisionnement automatique de l'hôte %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Les hôtes détectés sont maintenant provisionnés"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "L'hôte découvert a signalé qu'il provient d'un sous-réseau inconnu, la communication ne sera pas assurée par un proxy."
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "Les hôtes découverts provenant d'un sous-réseau inconnu sont %s, la communication ne sera pas assurée par un proxy.."
      ],
      "No hosts were found with that id or name": [
        "Aucun Hôte trouvé avec cet id ou ce nom"
      ],
      "No hosts selected": [
        "Aucun hôte sélectionné"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Une erreur s'est produite lors de la sélection des hôtes - %s"
      ],
      "Rule enabled": [
        "Règle activée"
      ],
      "Rule disabled": [
        "Règle désactivée"
      ],
      "Auto Provision": [
        "Provisionner automatiquement"
      ],
      "Refresh facts": [
        "Rafraîchir les facts"
      ],
      "Reboot": [
        "Redémarrer"
      ],
      "Back": [
        "Précédent"
      ],
      "Select Action": [
        "Choisir l'action"
      ],
      "Delete %s?": [
        "Supprimer %s?"
      ],
      "Assign Organization": [
        "Assigner une Organisation"
      ],
      "Assign Location": [
        "Assigner une Localisation"
      ],
      "Delete": [
        "Supprimer"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - les hôtes suivants vont être changés"
      ],
      "N/A": [
        "Sans objet"
      ],
      "New in the last 24 hours": [
        "Nouveau au cours des dernières 24 heures"
      ],
      "Not reported in more than 7 days": [
        "Non signalé dans plus de 7 jours"
      ],
      "Reported in the last 7 days": [
        "Signalé au cours des 7 derniers jours"
      ],
      "Provision": [
        "Mettre en service"
      ],
      "Discovered Hosts": [
        "Hôtes détectés"
      ],
      "Associated Hosts": [
        "Hôtes associés"
      ],
      "Disable": [
        "Désactiver"
      ],
      "Disable rule '%s'?": [
        "Désactiver la règle '%s' ?"
      ],
      "Enable": [
        "Activer"
      ],
      "Enable rule '%s'?": [
        "Activer la règle '%s' ?"
      ],
      "Clone": [
        "Cloner"
      ],
      "Delete rule '%s'?": [
        "Supprimer la règle '%s' ?"
      ],
      "Invalid user type of %s was provided": [
        "Le type d'utilisateur non valide %s a été fourni"
      ],
      "Discovered hosts summary": [
        "Synthèse des hôtes détectés"
      ],
      "can't contain white spaces.": [
        "ne peut pas contenir des espaces blancs."
      ],
      "must start with a letter or ERB.": [
        "doit commencer par une lettre ou par ERB."
      ],
      "must be present.": [
        "doit être présent."
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "L'organisation du groupe d'hôtes %s doit également être associée à la règle de détection",
        "L'organisation du groupe d'hôtes %s doit également être associée à la règle de détection",
        "L'organisation du groupe d'hôtes %s doit également être associée à la règle de détection"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "L'emplacement du groupe d'hôtes %s doit également être associé à la règle de détection",
        "L'emplacement du groupe d'hôtes %s doit également être associé à la règle de détection",
        "L'emplacement du groupe d'hôtes %s doit également être associé à la règle de détection"
      ],
      "Fact + prefix": [
        "Fact + préfixe"
      ],
      "Random name": [
        "Nom aléatoire"
      ],
      "MAC-based name": [
        "Nom basé MAC"
      ],
      "Invalid facts, must be a Hash": [
        "Facts non valides, doit être un hachage"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "discovery_fact '%s' attendu manquant. Impossible de détecter l'interface principale et de définir le nom d'hôte"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "Facts non valides : le hachage ne contient pas de valeur valide pour les facts du paramètre discovery_hostname : %s"
      ],
      "Facts could not be imported": [
        "Impossible d'importer les facts"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "Impossible d'obtenir les facts du proxy %{url}: %{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "Impossible d'effectuer un redémarrage sur %{name} (%{url}): %{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "Impossible d'exécuter %{action}: sur %{ips}"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "Impossible d'exécuter kexec sur %{name} (%{url}): %{msg}"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "Nom d'hôte non valide. Impossible de normaliser le nom d'hôte"
      ],
      "Reloading kernel on %s": [
        "Rechargement du noyau sur %s"
      ],
      "Rebooting %s": [
        "Redémarrage %s"
      ],
      "Kexec template not associated with operating system": [
        "Modèle kexec non associé à un système d'exploitation"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "URL kexec du noyau non valide : '%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "URL kexec RAM d'initialisation non valide : '%s'"
      ],
      "Rebuild DNS for %s": [
        "Reconstruire DNS pour %s"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "L'analyseur de faits de découverte ne fonctionne pas avec l'hôte de non-découverte '%{host}'"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "L'hôte découvert '%{host}' a eu toutes ces interfaces réseau filtrés, filtre: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "Impossible de trouver la carte réseau primaire avec %{mac} spécifié par '%{fact}', filtre NIC : %{filter}"
      ],
      "Highlights": [
        "Surlignages"
      ],
      "Storage": [
        "Stockage"
      ],
      "Hardware": [
        "Matériel"
      ],
      "Network": [
        "Réseau"
      ],
      "Software": [
        "Logiciel"
      ],
      "IPMI": [
        "IPMI "
      ],
      "Miscellaneous": [
        "Divers"
      ],
      "IPAM must be configured for subnet '%s'": [
        "L'IPAM doit être configuré pour le sous-réseau \\\"%s\\\""
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
        "L'API image renvoie HTTP/%{code}  avec '%'{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "Erreur de traitement de l'API image : %{msg} (HTTP/%{code}, body: %{body})"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "L’hôte %s a été découvert"
      ],
      "Discovered Host": [
        "Hôtes détectés",
        "Hôtes détectés",
        "Hôtes détectés"
      ],
      "No discovered hosts available": [
        "Aucun hôte détecté disponible"
      ],
      "Host": [
        "Hôte"
      ],
      "Model": [
        "Modéliser"
      ],
      "CPUs": [
        "Processeurs"
      ],
      "Memory": [
        "Mémoire"
      ],
      "Customize Host": [
        "Personnaliser l'hôte"
      ],
      "Create Host": [
        "Créer un hôte"
      ],
      "Select all items in this page": [
        "Sélectionner tous les éléments de cette page"
      ],
      "items selected. Uncheck to Clear": [
        "items sélectionnés. Décocher pour Effacer"
      ],
      "Name": [
        "Nom"
      ],
      "IP Address": [
        "Adresse IP"
      ],
      "Disk Count": [
        "Nombre de disques"
      ],
      "Disks Size": [
        "Taille des disques"
      ],
      "Location": [
        "Emplacement"
      ],
      "Organization": [
        "Organisation"
      ],
      "Subnet": [
        "Sous-réseau"
      ],
      "Last Facts Upload": [
        "Derniers facts téléchargés"
      ],
      "Actions": [
        "Actions"
      ],
      "Please Confirm": [
        "Merci de confirmer"
      ],
      "Cancel": [
        "Annuler"
      ],
      "Submit": [
        "Envoyer"
      ],
      "Provision %s": [
        "Provision %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "Cette action peut prendre un certain temps, pour tous les hôtes, les rapports et facts vont aussi être supprimés"
      ],
      "Select location": [
        "Sélectionner une localisation"
      ],
      "Select organization": [
        "Choisir une organisation"
      ],
      "Discovered host: %s": [
        "Hôtes détectés : %s"
      ],
      "Interfaces": [
        "Interfaces"
      ],
      "Type": [
        "Type"
      ],
      "Identifier": [
        "Identificateur"
      ],
      "MAC address": [
        "Adresse MAC"
      ],
      "IP address": [
        "Adresse IP"
      ],
      "Collapse All": [
        "Réduire tout"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Rapport de synthèse des hôtes détectés depuis Foreman"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "Synthèse des hôtes détectés par <b>Foreman</b> "
      ],
      "Summary from %{time} ago to %{now}": [
        "Résumé du %{time} précédent au %{now}"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Hôtes détectés depuis le serveur Foreman à l'adresse %{foreman_url}"
      ],
      "Disk count": [
        "Nombre de disques"
      ],
      "Disks size": [
        "Taille des disques"
      ],
      "No discovered hosts for the selected period": [
        "Aucun hôte détecté pendant la période sélectionnée"
      ],
      "Foreman discovered hosts summary": [
        "Synthèse des hôtes détectés Foreman"
      ],
      "No new discovered hosts for this period": [
        "Aucun nouvel hôte détecté pendant cette période"
      ],
      "Primary": [
        "Primaire"
      ],
      "Locations": [
        "Emplacements"
      ],
      "Organizations": [
        "Organisations"
      ],
      "Target host group for this rule with all properties set": [
        "Groupe d'hôtes cible pour cette règle avec toutes les propriétés définies"
      ],
      "Hostname for provisioned hosts": [
        "Nom d'hôte des hôtes provisionnés"
      ],
      "Hosts Limit": [
        "Limite d'hôtes"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Nombre maximal d'hôtes provisionnés avec cette règle (0 = illimité)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Priorité des règles (plus le nombre est petit, plus la priorité est élevée)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Spécifiez le modèle de nom d'hôte cible dans la même syntaxe que celle des modèles de provisioning (ERB)."
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "Le domaine sera ajouté automatiquement. Un nom d'hôte basé sur une adresse MAC sera utilisé si le champ est vide."
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "En plus de la fonction d'attribut @host, la fonction ALEA pour les entiers aléatoires est disponible. Exemples :"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "Lors de la création de modèles de nom d'hôte, veillez à ce que les noms d'hôte soient uniques."
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "Les noms d'hôte ne doivent pas commencer par des nombres. Une bonne méthode consiste à utiliser des informations uniques fournies par facter (adresse MAC, BIOS ou ID de série)."
      ],
      "Clone %s": [
        "Clone %s"
      ],
      "Edit %s": [
        "Modifier %s"
      ],
      "Discovery Rules": [
        "Règles de détection"
      ],
      "Create Rule": [
        "Créer une règle"
      ],
      "DiscoveryRule|Name": [
        "Nom"
      ],
      "DiscoveryRule|Priority": [
        "Priorité"
      ],
      "DiscoveryRule|Query": [
        "Requête"
      ],
      "Host Group": [
        "Groupe d'hôtes"
      ],
      "Hosts/Limit": [
        "Hôtes/Limite"
      ],
      "DiscoveryRule|Enabled": [
        "Activé"
      ],
      "New Discovery Rule": [
        "Nouvelle règle de détection"
      ],
      "Discovered Rules": [
        "Hôtes détectés"
      ],
      "A summary of discovered hosts": [
        "Synthèse des hôtes détectés"
      ],
      "New hosts": [
        "Nouveaux hôtes"
      ],
      "One or more hosts have been discovered": [
        "Un ou plusieurs hôtes ont été détectés"
      ],
      "Details": [
        "Détails"
      ],
      "Hosts": [
        "Hôtes"
      ],
      "Error message goes here": [
        "Le message d'erreur se trouve ici"
      ],
      "Discovery": [
        "Discovery"
      ],
      "Discovery location": [
        "Emplacement de détection"
      ],
      "The default location to place discovered hosts in": [
        "Attribution de la localisation par défaut pour les hôtes détectés"
      ],
      "Discovery organization": [
        "Organisation de détection"
      ],
      "The default organization to place discovered hosts in": [
        "Attribution de l'organisation par défaut pour les hôtes détectés"
      ],
      "Interface fact": [
        "Fact d'interface"
      ],
      "Fact name to use for primary interface detection": [
        "Nom de fact à utiliser pour la détection de l'interface principale"
      ],
      "Create bond interfaces": [
        "Créer des interfaces de liaison"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "Interface de liaison automatique (si une autre interface est détectée sur le même VLAN via LLDP)"
      ],
      "Clean all facts": [
        "Nettoyer tous les facts"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "Nettoyer tous les facts signalés pendant le provisioning (sauf les facts de détection)"
      ],
      "Hostname facts": [
        "Facts du nom d'hôte"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "Provisioning automatique"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "Provisionner automatiquement les hôtes récemment détectés conformément aux règles de provisioning"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "Redémarrer automatiquement ou effectuer un kexec sur l'hôte détecté pendant le provisioning"
      ],
      "Hostname prefix": [
        "Préfixe du nom d'hôte"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "Préfixe par défaut à utiliser pour le nom d'hôte, doit commencer par une lettre"
      ],
      "Fact columns": [
        "Colonnes fact"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "Facts surlignés"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "Expression régulière pour organiser les facts pour la section surlignages, par ex. ^(abc|cde)$"
      ],
      "Storage facts": [
        "Facts de stockage"
      ],
      "Regex to organize facts for storage section": [
        "Expression régulière pour organiser les facts pour la section stockage"
      ],
      "Software facts": [
        "Facts logiciels"
      ],
      "Regex to organize facts for software section": [
        "Expression régulière pour organiser les facts pour la section logiciel"
      ],
      "Hardware facts": [
        "Facts matériels"
      ],
      "Regex to organize facts for hardware section": [
        "Expression régulière pour organiser les facts pour la section matériel"
      ],
      "Network facts": [
        "Facts réseau"
      ],
      "Regex to organize facts for network section": [
        "Expression régulière pour organiser les facts pour la section réseau"
      ],
      "IPMI facts": [
        "Facts IPMI"
      ],
      "Regex to organize facts for ipmi section": [
        "Expression régulière pour organiser les facts pour la section ipmi"
      ],
      "Lock PXE": [
        "Verrouiller PXE"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "Générer automatiquement la configuration PXE pour épingler un hôte récemment détecté"
      ],
      "Locked PXELinux template name": [
        "Nom de modèle PXELinux verrouillé"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "Modèle PXELinux à utiliser lors de l'épinglage d'un hôte pour la détection"
      ],
      "Locked PXEGrub template name": [
        "Nom de modèle PXEGrub verrouillé"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "Modèle PXEGrub à utiliser lors de l'épinglage d'un hôte pour la détection"
      ],
      "Locked PXEGrub2 template name": [
        "Nom de modèle PXEGrub2 verrouillé"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "Modèle PXEGrub2 à utiliser lors de l'épinglage d'un hôte pour la détection"
      ],
      "Force DNS": [
        "Forcer DNS"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "Forcer la création des entrées DNS lors du provisioning de l'hôte détecté"
      ],
      "Error on existing NIC": [
        "Erreur sur une carte réseau existante"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "Ne pas autoriser la découverte du MAC correspondant à un hôte géré existant d'une carte réseau de provisionnement (erreurs survenues tôt)"
      ],
      "Type of name generator": [
        "Générateur type de nom"
      ],
      "Discovery hostname naming pattern": [
        "Modèle de nommage du nom d'hôte de découverte"
      ],
      "Prefer IPv6": [
        "Préférer IPv6"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "Préférer IPv6 à IPv4 lors de l'appel des nœuds découverts"
      ],
      "Discovery Proxy": [
        "Proxy de détection"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "Proxy de détection à utiliser à l'intérieur de ce sous-réseau pour gérer la connexion aux hôtes détectés"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "ID du proxy de détection à utiliser à l'intérieur de ce sous-réseau pour gérer la connexion aux hôtes détectés"
      ],
      "For more information please see ": [
        "Pour plus d'informations, voir "
      ],
      "documentation": [
        "documentation"
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        "Aucun hôte découvert dans ce contexte. Cette page montre les nœuds nus ou virtuels découverts qui attendent d'être approvisionnés."
      ],
      "Foreman Discovery": [
        ""
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        "Aucune règle de découverte trouvée dans ce contexte. Créer des règles de découverte pour effectuer un provisionnement automatique sur les hôtes découverts."
      ],
      "Remote action:": [
        "Action distante :"
      ],
      "Import Puppet classes": [
        "Importer des classes Puppet"
      ],
      "Import facts": [
        "Importer des faits"
      ],
      "Action with sub plans": [
        "Action avec sous-plans"
      ]
    }
  }
};