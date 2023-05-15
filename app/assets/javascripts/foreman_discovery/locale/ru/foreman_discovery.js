 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['ru'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Yulia <yulia.poyarkova@redhat.com>, 2016",
        "Language-Team": "Russian (http://www.transifex.com/foreman/foreman/language/ru/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "ru",
        "Plural-Forms": "nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || (n%10>=5 && n%10<=9) || (n%100>=11 && n%100<=14)? 2 : 3);",
        "lang": "ru",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=4; plural=(n%10==1 && n%100!=11 ? 0 : n%10>=2 && n%10<=4 && (n%100<12 || n%100>14) ? 1 : n%10==0 || (n%10>=5 && n%10<=9) || (n%100>=11 && n%100<=14)? 2 : 3);"
      },
      "List all discovered hosts": [
        "Показать все обнаруженные узлы"
      ],
      "filter results": [
        "отфильтровать результаты"
      ],
      "sort results": [
        "отсортировать результаты"
      ],
      "paginate results": [
        "постраничный вывод"
      ],
      "number of entries per request": [
        "количество записей на запрос"
      ],
      "Show a discovered host": [
        "Показать обнаруженный узел"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        ""
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Создать узел на базе обнаруженного для тестирования (используйте /facts для создания новых узлов)"
      ],
      "Provision a discovered host": [
        "Подготовить обнаруженный узел"
      ],
      "required if host is managed and value is not inherited from host group": [
        "требуется, если узел уже контролируется, но значение не было унаследовано от группы узлов"
      ],
      "not required if using a subnet with DHCP proxy": [
        "не требуется, если используется подсеть с DHCP прокси"
      ],
      "not required if it's a virtual machine": [
        "не требуется для виртуальных машин"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "требуется, если подготовка управляемого узла осуществляется без участия образов и при этом значение не было унаследовано от группы узлов"
      ],
      "required if host is managed and custom partition has not been defined": [
        "требуется, если узел находится под управлением, но собственный раздел не был объявлен"
      ],
      "Host's owner type": [
        "Тип владельца узла"
      ],
      "Host's parameters (array or indexed hash)": [
        "Параметры узла (массив или индексированный хэш)"
      ],
      "Name of the parameter": [
        "Название параметра"
      ],
      "Parameter value": [
        "Значение параметра"
      ],
      "Type of value": [
        "Тип значения"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID для отслеживания состояния задач оркестрации, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "обязательно, если пароль не унаследован от группы узлов или заданного по умолчанию пароля"
      ],
      "Delete a discovered host": [
        "Удалить обнаруженный узел"
      ],
      "Upload facts for a host, creating the host if required": [
        "Загрузить факты узла, требуемые для создания узла"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "хэш с минимальным набором фактов узла: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (в этих примерах подразумевается, что основной интерфейс имеет имя  eth0)"
      ],
      "Execute rules against a discovered host": [
        "Применить правила к обнаруженному узлу"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "%{host} был подготовлен в соответствии с правилом %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "Не удалось подготовить %{host}: %{errors}"
      ],
      "No rule found for host %s": [
        "Нет правил для %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Применить правила ко всем обнаруженным узлам"
      ],
      "Errors during auto provisioning: %s": [
        "Ошибки при автоматической подготовке: %s"
      ],
      "No discovered hosts to provision": [
        "Нет обнаруженных узлов"
      ],
      "%s discovered hosts were provisioned": [
        "Подготовлено узлов: %s"
      ],
      "Refreshing the facts of a discovered host": [
        "Обновление фактов узла"
      ],
      "Rebooting a discovered host": [
        "Перезагрузка обнаруженного узла"
      ],
      "Rebooting all discovered hosts": [
        "Перезагрузка всех обнаруженных узлов"
      ],
      "Discovered hosts are rebooting now": [
        "Выполняется перезагрузка обнаруженных узлов"
      ],
      "List all discovery rules": [
        "Показать все правила обнаружения"
      ],
      "Show a discovery rule": [
        "Показать правило"
      ],
      "represents rule name shown to the users": [
        "название правила, которое увидят пользователи"
      ],
      "query to match discovered hosts for the particular rule": [
        "запрос для поиска соответствий среди узлов для этого правила"
      ],
      "the hostgroup that is used to auto provision a host": [
        "группа узлов, которая будет выбрана при автоматической подготовке узлов"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "шаблон для присвоения узлам понятных имен"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "максимальное число узлов для указанного правила"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "приоритет правила (должен быть больше 0). Правила выбираются по возрастанию приоритета"
      ],
      "flag is used for temporary shutdown of rules": [
        "этот флаг временно отключает правила"
      ],
      "location ID for provisioned hosts": [
        ""
      ],
      "organization ID for provisioned hosts": [
        ""
      ],
      "Create a discovery rule": [
        "Создать правило"
      ],
      "Update a rule": [
        "Обновить правило"
      ],
      "Delete a rule": [
        "Удалить правило"
      ],
      "List all fact values of a given discovered host": [
        ""
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "Не удалось найти правило: необходимо указать узел. Проверьте разрешения."
      ],
      "No hostgroup associated with rule '%s'": [
        "Правило «%s» не связано ни с одной группой узлов"
      ],
      "Errors during reboot: %s": [
        "Ошибки при перезагрузке: %s"
      ],
      "No discovered hosts to reboot": [
        "Нет узлов для перезагрузки"
      ],
      "Successfully provisioned %s": [
        ""
      ],
      "Facts refreshed for %s": [
        "Факты %s были обновлены"
      ],
      "Failed to refresh facts for %s": [
        "Не удалось обновить факты %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "Не удалось обновить факты %{hostname}. Ошибка: %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "Узел типа %s не может быть перезагружен"
      ],
      "Rebooting host %s": [
        "Перезагрузка %s"
      ],
      "Failed to reboot host %s": [
        "Не удалось перезагрузить %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Не удалось перезагрузить %{hostname}. Ошибка: %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "Не удалось перезагрузить узлы. Ошибка: %s"
      ],
      "Destroyed selected hosts": [
        "Узлы удалены"
      ],
      "The following hosts were not deleted: %s": [
        "Узлы не были удалены: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Не удалось автоматически подготовить узел %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Выполняется подготовка обнаруженных узлов"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        "Нет узла с таким идентификатором или именем"
      ],
      "No hosts selected": [
        "Не выбран узел"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Непредвиденное поведение при выборе узлов: %s"
      ],
      "Rule enabled": [
        "Правило включено"
      ],
      "Rule disabled": [
        "Правило отключено"
      ],
      "Auto Provision": [
        "Автоматическая подготовка"
      ],
      "Refresh facts": [
        "Обновить факты"
      ],
      "Reboot": [
        "Перезагрузить"
      ],
      "Back": [
        "Назад"
      ],
      "Select Action": [
        "Действия"
      ],
      "Delete %s?": [
        "Удалить %s?"
      ],
      "Assign Organization": [
        "Назначить организацию"
      ],
      "Assign Location": [
        "Выбрать местоположение"
      ],
      "Delete": [
        "Удалить"
      ],
      "%s - The following hosts are about to be changed": [
        "%s — узлы будут изменены"
      ],
      "N/A": [
        "нет"
      ],
      "New in the last 24 hours": [
        "Новое за последние 24 часа"
      ],
      "Not reported in more than 7 days": [
        "Не было данных за последние 7 дней"
      ],
      "Reported in the last 7 days": [
        "Были данные за последние 7 дней"
      ],
      "Provision": [
        "Подготовить"
      ],
      "Discovered Hosts": [
        "Обнаруженные узлы"
      ],
      "Associated Hosts": [
        "Сопоставленные узлы"
      ],
      "Disable": [
        "Отключить"
      ],
      "Disable rule '%s'?": [
        "Отключить правило «%s»?"
      ],
      "Enable": [
        "Включить"
      ],
      "Enable rule '%s'?": [
        "Включить правило «%s»?"
      ],
      "Clone": [
        "Клонировать"
      ],
      "Delete rule '%s'?": [
        "Удалить правило «%s»?"
      ],
      "Invalid user type of %s was provided": [
        ""
      ],
      "Discovered hosts summary": [
        "Сводка обнаруженных узлов"
      ],
      "can't contain white spaces.": [
        "не может содержать пробелов"
      ],
      "must start with a letter or ERB.": [
        "должен начинаться с буквы или ERB"
      ],
      "must be present.": [
        ""
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "С правилом также необходимо связать организацию группы узлов, %s",
        "С правилом также необходимо связать организации группы узлов: %s",
        "С правилом также необходимо связать организации группы узлов: %s",
        "С правилом также необходимо связать организации группы узлов: %s"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "С правилом также необходимо связать местоположение группы узлов, %s",
        "С правилом также необходимо связать местоположения групп узлов: %s",
        "С правилом также необходимо связать местоположения групп узлов: %s",
        "С правилом также необходимо связать местоположения групп узлов: %s"
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
        "Недопустимый формат фактов: ожидаются переменные и их значения"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "Отсутствует факт «%s»: невозможно определить основной интерфейс и имя узла"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "Недействительные факты: строка не содержит ни одного действительного значения фактов в соответствии с заданным в discovery_hostname: %s"
      ],
      "Facts could not be imported": [
        ""
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "Не удалось получить факты с %{url}: %{error}"
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
        "Не удалось нормализовать имя узла"
      ],
      "Reloading kernel on %s": [
        "Перезагрузка ядра на %s"
      ],
      "Rebooting %s": [
        "Перезагрузка %s"
      ],
      "Kexec template not associated with operating system": [
        "Шаблон kexec не привязан к операционной системе"
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
        "Основные"
      ],
      "Storage": [
        "Хранение данных"
      ],
      "Hardware": [
        "Физическое"
      ],
      "Network": [
        "Сеть"
      ],
      "Software": [
        "Программы"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "Дополнительно"
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
        "API образа вернул ошибку HTTP/%{code}: '%{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "API образа вернул ошибку HTTP/%{code}: %{msg} (body: %{body})"
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
        "Нет обнаруженных узлов"
      ],
      "Host": [
        "Узел"
      ],
      "Model": [
        "Модель"
      ],
      "CPUs": [
        "Процессоры"
      ],
      "Memory": [
        "Память"
      ],
      "Customize Host": [
        ""
      ],
      "Create Host": [
        "Создать Узел"
      ],
      "Select all items in this page": [
        "Выбрать все элементы на странице"
      ],
      "items selected. Uncheck to Clear": [
        "выбрано. Чтобы очистить, снимите флажок"
      ],
      "Name": [
        "Имя"
      ],
      "IP Address": [
        "IP"
      ],
      "Disk Count": [
        ""
      ],
      "Disks Size": [
        ""
      ],
      "Location": [
        "Местоположение"
      ],
      "Organization": [
        "Организация"
      ],
      "Subnet": [
        "Подсеть"
      ],
      "Last Facts Upload": [
        ""
      ],
      "Actions": [
        "Действия"
      ],
      "Please Confirm": [
        "Подтвердите"
      ],
      "Cancel": [
        "Отмена"
      ],
      "Submit": [
        "Подтвердить"
      ],
      "Provision %s": [
        ""
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "Это может занять некоторое время, так как в ходе выполнения будут удалены узлы, статистика и все отчеты"
      ],
      "Select location": [
        "Выберите местоположение"
      ],
      "Select organization": [
        "Выберите организацию"
      ],
      "Discovered host: %s": [
        "Обнаружен узел: %s"
      ],
      "Interfaces": [
        "Интерфейсы"
      ],
      "Type": [
        "Тип"
      ],
      "Identifier": [
        "Идентификатор"
      ],
      "MAC address": [
        "MAC-адрес"
      ],
      "IP address": [
        "IP-адрес"
      ],
      "Collapse All": [
        "Свернуть все"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Сводный отчет Foreman по обнаруженным узлам"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "Сводка обнаруженных узлов от <b>Foreman</b>"
      ],
      "Summary from %{time} ago to %{now}": [
        "Сводка за %{time} — %{now}"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Узлы, обнаруженные сервером Foreman %{foreman_url}"
      ],
      "Disk count": [
        "Количество дисков"
      ],
      "Disks size": [
        "Размер диска"
      ],
      "No discovered hosts for the selected period": [
        "За указанный период времени новых узлов не обнаружено"
      ],
      "Foreman discovered hosts summary": [
        "Сводка обнаруженных узлов Foreman"
      ],
      "No new discovered hosts for this period": [
        "За это время новых узлов не обнаружено"
      ],
      "Primary": [
        "Основной"
      ],
      "Locations": [
        "Местоположения"
      ],
      "Organizations": [
        "Организации"
      ],
      "Target host group for this rule with all properties set": [
        "Группа узлов для этого правила с настроенными параметрами"
      ],
      "Hostname for provisioned hosts": [
        "Имя узла"
      ],
      "Hosts Limit": [
        "Ограничение узлов"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Максимальное число инициализируемых узлов в соответствии с правилом (0 снимает ограничения)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Приоритет (чем ниже число, тем выше приоритет)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Определите шаблон для узла, используя синтаксис, аналогичный используемому в подготовительных шаблонах (ERB)."
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
        "Клонировать %s"
      ],
      "Edit %s": [
        "Изменить %s"
      ],
      "Discovery Rules": [
        "Правила обнаружения"
      ],
      "Create Rule": [
        ""
      ],
      "DiscoveryRule|Name": [
        "Имя"
      ],
      "DiscoveryRule|Priority": [
        "Приоритет"
      ],
      "DiscoveryRule|Query": [
        "Запрос"
      ],
      "Host Group": [
        "Группа узлов"
      ],
      "Hosts/Limit": [
        ""
      ],
      "DiscoveryRule|Enabled": [
        "Включено"
      ],
      "New Discovery Rule": [
        "Новое правило"
      ],
      "Discovered Rules": [
        ""
      ],
      "A summary of discovered hosts": [
        "Сводка состояния обнаруженных узлов"
      ],
      "New hosts": [
        ""
      ],
      "One or more hosts have been discovered": [
        ""
      ],
      "Details": [
        "Свойства"
      ],
      "Hosts": [
        "Узлы"
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
        "Местоположение для обнаруженных узлов по умолчанию"
      ],
      "Discovery organization": [
        ""
      ],
      "The default organization to place discovered hosts in": [
        "Организация для обнаруженных узлов по умолчанию"
      ],
      "Interface fact": [
        ""
      ],
      "Fact name to use for primary interface detection": [
        "Имя факта, определяющего основной сетевой интерфейс и имя узла"
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
        "Автоматически подготовить обнаруженные узлы в соответствии с заранее определенными правилами"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        ""
      ],
      "Hostname prefix": [
        ""
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "Префикс имени узла (должен начинаться с буквы)"
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
        "Регулярное выражение для организации фактов в списке «Основные», например: ^(abc|cde)$"
      ],
      "Storage facts": [
        ""
      ],
      "Regex to organize facts for storage section": [
        "Регулярное выражение для организации фактов в секции «Хранилище»"
      ],
      "Software facts": [
        ""
      ],
      "Regex to organize facts for software section": [
        "Регулярное выражение для организации фактов в секции «Программное обеспечение»"
      ],
      "Hardware facts": [
        ""
      ],
      "Regex to organize facts for hardware section": [
        "Регулярное выражение для организации фактов в секции «Оборудование»"
      ],
      "Network facts": [
        ""
      ],
      "Regex to organize facts for network section": [
        "Регулярное выражение для организации фактов в секции «Сеть»"
      ],
      "IPMI facts": [
        ""
      ],
      "Regex to organize facts for ipmi section": [
        "Регулярное выражение для организации фактов в секции «IPMI»"
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
        "За подробной информацией обратитесь к"
      ],
      "documentation": [
        "документация"
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
        "Удаленное действие:"
      ],
      "Import Puppet classes": [
        "Импорт классов Puppet"
      ],
      "Import facts": [
        "Импорт фактов"
      ],
      "Action with sub plans": [
        "Действия с подпланами"
      ]
    }
  }
};