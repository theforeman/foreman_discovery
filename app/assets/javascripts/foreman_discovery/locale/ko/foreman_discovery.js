 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['ko'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "FULL NAME <EMAIL@ADDRESS>",
        "Language-Team": "Korean (http://www.transifex.com/foreman/foreman/language/ko/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "ko",
        "Plural-Forms": "nplurals=1; plural=0;",
        "lang": "ko",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=1; plural=0;"
      },
      "List all discovered hosts": [
        "검색된 모든 호스트를 나열 "
      ],
      "filter results": [
        "필터 결과 "
      ],
      "sort results": [
        "결과 정렬 "
      ],
      "paginate results": [
        "페이지네이션 결과 "
      ],
      "number of entries per request": [
        "요청 당 항목 수 "
      ],
      "Show a discovered host": [
        "검색된 호스트 표시 "
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        ""
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "검색된 호스트를 테스트용으로 생성(/facts를 사용하여 새 호스트 생성)"
      ],
      "Provision a discovered host": [
        "검색된 호스트 프로비저닝 "
      ],
      "required if host is managed and value is not inherited from host group": [
        "호스트가 관리되고 있으며 값이 호스트 그룹에서 상속되지 않은 경우에 필요합니다 "
      ],
      "not required if using a subnet with DHCP proxy": [
        "DHCP 프록시를 갖는 서브넷을 사용할 필요가 없습니다 "
      ],
      "not required if it's a virtual machine": [
        "가상 머신의 경우 필요하지 않습니다 "
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "이미지 기반의 프로비저닝이 아니고 호스트가 관리되어 값이 호스트 그룹에서 상속되지 않은 경우에 필요합니다 "
      ],
      "required if host is managed and custom partition has not been defined": [
        "호스트가 관리되고 있으며 사용자 정의 파티션이 정의되고 있지 않은 경우에 필요합니다 "
      ],
      "Host's owner type": [
        "호스트의 소유자 유형"
      ],
      "Host's parameters (array or indexed hash)": [
        "호스트의 매개 변수(배열 또는 인덱싱된 해시)"
      ],
      "Name of the parameter": [
        "매개 변수의 이름"
      ],
      "Parameter value": [
        "매개 변수 값"
      ],
      "Type of value": [
        ""
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "오케스트레이션 작업 상태를 추적하기 위한 UUID, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "값이 호스트 그룹이나 설정의 기본값 암호에서 상속되지 않은 경우에 필요합니다 "
      ],
      "Delete a discovered host": [
        "검색된 호스트 삭제 "
      ],
      "Upload facts for a host, creating the host if required": [
        "호스트의 팩트를 업로드하고 필요한 경우 호스트를 생성합니다 "
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "최소 세트의 팩트가 있는 호스트의 팩트가 포함된 해시: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, 인터페이스: eth0(기본 인터페이스의 이름이 eth0인 경우의 예)"
      ],
      "Execute rules against a discovered host": [
        "검색된 호스트에 대해 규칙 실행 "
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "호스트 %{host}은/는 %{rule}으(로) 프로비저닝됩니다 "
      ],
      "Unable to provision %{host}: %{errors}": [
        "%{host}을(를) 프로비저닝할 수 없습니다: %{errors}"
      ],
      "No rule found for host %s": [
        "호스트 %s에 대한 규칙을 찾을 수 없습니다 "
      ],
      "Execute rules against all currently discovered hosts": [
        "현재 검색된 모든 호스트에 대해 규칙 실행 "
      ],
      "Errors during auto provisioning: %s": [
        "자동 프로비저닝 도중 오류 발생: %s"
      ],
      "No discovered hosts to provision": [
        "프로비저닝할 검색된 호스트가 없습니다 "
      ],
      "%s discovered hosts were provisioned": [
        "%s개의 검색된 호스트를 프로비저닝했습니다."
      ],
      "Refreshing the facts of a discovered host": [
        "검색된 호스트의 팩트를 새로고침 중 "
      ],
      "Rebooting a discovered host": [
        "검색된 호스트를 재부팅 중 "
      ],
      "Rebooting all discovered hosts": [
        "검색된 모든 호스트를 재부팅 중"
      ],
      "Discovered hosts are rebooting now": [
        "현재 검색된 호스트를 재부팅하고 있습니다."
      ],
      "List all discovery rules": [
        "모든 검색 규칙을 나열 "
      ],
      "Show a discovery rule": [
        "검색 규칙 표시 "
      ],
      "represents rule name shown to the users": [
        "사용자에게 표시되는 규칙 이름을 표시합니다"
      ],
      "query to match discovered hosts for the particular rule": [
        "특정 규칙에 대해 검색된 호스트와 일치하는 쿼리"
      ],
      "the hostgroup that is used to auto provision a host": [
        "호스트를 자동 프로비저닝하기 위해 사용되는 호스트 그룹"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "해당 호스트에 읽기 좋은 호스트 이름을 할당하기 위해 패턴을 정의합니다"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "규칙 당 프로비저닝된 호스트의 최대 수량을 제한할 수 있게 합니다"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "규칙을 순서대로 배치합니다. 낮은 숫자를 먼저 배치합니다. 수치는 0 보다 커야 합니다"
      ],
      "flag is used for temporary shutdown of rules": [
        "규칙의 일시 정지에 플래그를 사용합니다"
      ],
      "location ID for provisioned hosts": [
        ""
      ],
      "organization ID for provisioned hosts": [
        ""
      ],
      "Create a discovery rule": [
        "검색 규칙 생성 "
      ],
      "Update a rule": [
        "규칙 업데이트 "
      ],
      "Delete a rule": [
        "규칙 삭제 "
      ],
      "List all fact values of a given discovered host": [
        ""
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "검색 규칙을 찾을 수 없습니다. 호스트가 제공되지 않았습니다(권한 확인)."
      ],
      "No hostgroup associated with rule '%s'": [
        "'%s' 규칙에 연결된 호스트 그룹이 없습니다."
      ],
      "Errors during reboot: %s": [
        "재부팅 도중 오류가 발생했습니다: %s"
      ],
      "No discovered hosts to reboot": [
        "재부팅할 검색된 호스트가 없습니다."
      ],
      "Successfully provisioned %s": [
        ""
      ],
      "Facts refreshed for %s": [
        "%s에 대해 업데이트된 팩트"
      ],
      "Failed to refresh facts for %s": [
        "%s에 대한 팩트를 새로고침하는데 실패했습니다 "
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "%{error_message} 오류가 발생하여 %{hostname}의 팩트를 새로 고치지 못했습니다."
      ],
      "Host of type %s can not be rebooted": [
        "호스트 유형 %s은(는) 재부팅할 수 없습니다 "
      ],
      "Rebooting host %s": [
        "호스트 %s 재부팅 중 "
      ],
      "Failed to reboot host %s": [
        "호스트 %s 재부팅에 실패했습니다 "
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "오류 %{error_message}를 표시하는 호스트 %{hostname} 재부팅에 실패했습니다 "
      ],
      "Failed to reboot hosts with error %s": [
        "%s 오류가 발생하여 호스트를 재부팅하지 못했습니다."
      ],
      "Destroyed selected hosts": [
        "선택된 호스트 삭제"
      ],
      "The following hosts were not deleted: %s": [
        "다음 호스트가 삭제되지 않았습니다: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "호스트 %s의 자동 프로비저닝에 실패했습니다: %s"
      ],
      "Discovered hosts are provisioning now": [
        "현재 검색된 호스트를 프로비저닝하고 있습니다"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        ""
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        ""
      ],
      "No hosts were found with that id or name": [
        "해당 ID 또는 이름의 호스트를 찾을 수 없습니다 "
      ],
      "No hosts selected": [
        "선택된 호스트가 없음 "
      ],
      "Something went wrong while selecting hosts - %s": [
        "호스트를 선택하는 도중 문제가 발생했습니다 - %s"
      ],
      "Rule enabled": [
        "규칙 비활성화 "
      ],
      "Rule disabled": [
        "규칙 비활성화 "
      ],
      "Auto Provision": [
        "자동 프로비저닝 "
      ],
      "Refresh facts": [
        "팩트 새로고침 "
      ],
      "Reboot": [
        "다시 시작"
      ],
      "Back": [
        "뒤로 "
      ],
      "Select Action": [
        "작업 선택 "
      ],
      "Delete %s?": [
        "%s 을(를) 삭제하시겠습니까?"
      ],
      "Assign Organization": [
        "조직 지정 "
      ],
      "Assign Location": [
        "위치 지정 "
      ],
      "Delete": [
        "삭제 "
      ],
      "%s - The following hosts are about to be changed": [
        "%s - 다음 호스트는 즉시 변경됩니다 "
      ],
      "N/A": [
        "해당 없음 "
      ],
      "New in the last 24 hours": [
        "지난 24시간 이내의 신규 항목"
      ],
      "Not reported in more than 7 days": [
        "7일 넘게 보고되지 않음"
      ],
      "Reported in the last 7 days": [
        "지난 7일 이내에 보고됨"
      ],
      "Provision": [
        "프로비저닝 "
      ],
      "Discovered Hosts": [
        ""
      ],
      "Associated Hosts": [
        ""
      ],
      "Disable": [
        "비활성화 "
      ],
      "Disable rule '%s'?": [
        ""
      ],
      "Enable": [
        "활성화"
      ],
      "Enable rule '%s'?": [
        ""
      ],
      "Clone": [
        "복제(Clone)"
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
        "공백을 포함할 수 없습니다. "
      ],
      "must start with a letter or ERB.": [
        "문자 또는 ERB로 시작해야 합니다. "
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
        "잘못된 팩트, 해시여야 합니다 "
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "필요한 discovery_fact '%s'이(가) 누락되었습니다. 기본 인터페이스와 설정된 호스트 이름을 감지할 수 없습니다."
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        ""
      ],
      "Facts could not be imported": [
        ""
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "프록시 %{url}에서 팩트를 가져올 수 없습니다: %{error}"
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
        "%s에서 커널을 다시 로드하는 중"
      ],
      "Rebooting %s": [
        "%s 재부팅 중 "
      ],
      "Kexec template not associated with operating system": [
        "Kexec 템플릿이 운영 체제에 연결되어 있지 않습니다."
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
        "스토리지"
      ],
      "Hardware": [
        "하드웨어"
      ],
      "Network": [
        "네트워크"
      ],
      "Software": [
        "소프트웨어"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "기타"
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
        "이미지 API에서 '%{body}'이(가) 포함된 HTTP/%{code}을(를) 반환했습니다."
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "이미지 API 처리 오류: %{msg}(HTTP/%{code}, 본문: %{body})"
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
        "사용 가능한 검색된 호스트가 없습니다 "
      ],
      "Host": [
        "호스트"
      ],
      "Model": [
        "모델 "
      ],
      "CPUs": [
        "CPU"
      ],
      "Memory": [
        "메모리"
      ],
      "Customize Host": [
        ""
      ],
      "Create Host": [
        ""
      ],
      "Select all items in this page": [
        "이 페이지에 있는 모든 항목을 선택 "
      ],
      "items selected. Uncheck to Clear": [
        "항목이 선택되어 있습니다. 삭제하려면 선택 해제합니다 "
      ],
      "Name": [
        "이름 "
      ],
      "IP Address": [
        "IP 주소 "
      ],
      "Disk Count": [
        "디스크 수"
      ],
      "Disks Size": [
        ""
      ],
      "Location": [
        "위치 "
      ],
      "Organization": [
        "조직 "
      ],
      "Subnet": [
        "서브넷 "
      ],
      "Last Facts Upload": [
        ""
      ],
      "Actions": [
        "동작 "
      ],
      "Please Confirm": [
        "확인해 주십시오 "
      ],
      "Cancel": [
        "취소 "
      ],
      "Submit": [
        "제출 "
      ],
      "Provision %s": [
        ""
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "모든 호스트, 팩트, 보고서가 모두 삭제되기 때문에 시간이 걸릴 수 있습니다 "
      ],
      "Select location": [
        "위치 선택 "
      ],
      "Select organization": [
        "조직 선택 "
      ],
      "Discovered host: %s": [
        "검색된 호스트: %s"
      ],
      "Interfaces": [
        "인터페이스"
      ],
      "Type": [
        "유형 "
      ],
      "Identifier": [
        "식별자 "
      ],
      "MAC address": [
        "MAC 주소"
      ],
      "IP address": [
        "IP 주소 "
      ],
      "Collapse All": [
        "모두 축소"
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
        "디스크 수 "
      ],
      "Disks size": [
        "디스크 크기 "
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
        "주"
      ],
      "Locations": [
        "위치 "
      ],
      "Organizations": [
        "조직"
      ],
      "Target host group for this rule with all properties set": [
        "모든 속성 모음을 갖는 규칙의 대상 호스트 그룹 "
      ],
      "Hostname for provisioned hosts": [
        "프로비저닝된 호스트의 호스트 이름 "
      ],
      "Hosts Limit": [
        "호스트 제한"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "이 규칙에서 프로비저닝되는 최대 호스트 수 (0 = 무제한)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "규칙 우선 순위 (낮은 정수 값일수록 우선 순위가 높아짐)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "프로비저닝 템플릿 (ERB)에 있는 것과 동일한 구문의 대상 호스트 이름 템플릿 패턴을 지정합니다. "
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
        "%s 복제 "
      ],
      "Edit %s": [
        "%s 편집 "
      ],
      "Discovery Rules": [
        "검색 규칙 "
      ],
      "Create Rule": [
        ""
      ],
      "DiscoveryRule|Name": [
        "이름 "
      ],
      "DiscoveryRule|Priority": [
        "우선 순위 "
      ],
      "DiscoveryRule|Query": [
        "쿼리 "
      ],
      "Host Group": [
        "호스트 그룹 "
      ],
      "Hosts/Limit": [
        ""
      ],
      "DiscoveryRule|Enabled": [
        "활성화 "
      ],
      "New Discovery Rule": [
        "새 검색 규칙 "
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
        "상세 정보 "
      ],
      "Hosts": [
        "호스트"
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
        "검색된 호스트를 배치하기 위한 기본 위치 "
      ],
      "Discovery organization": [
        ""
      ],
      "The default organization to place discovered hosts in": [
        "검색된 호스트를 배치하기 위한 기본 조직 "
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
        "프로비저닝 규칙에 따라 새로 검색된 호스트의 자동 프로비저닝 "
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        ""
      ],
      "Hostname prefix": [
        ""
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "호스트 이름에 사용할 기본 접두사는 문자로 시작해야 합니다 "
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
        "스토리지 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Software facts": [
        ""
      ],
      "Regex to organize facts for software section": [
        "소프트웨어 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Hardware facts": [
        ""
      ],
      "Regex to organize facts for hardware section": [
        "하드웨어 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Network facts": [
        ""
      ],
      "Regex to organize facts for network section": [
        "네트워크 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "IPMI facts": [
        ""
      ],
      "Regex to organize facts for ipmi section": [
        "ipmi 섹션의 팩트를 구성하기 위한 정규식"
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
        "원격 작업:"
      ],
      "Import Puppet classes": [
        "Puppet 클래스 가져오기"
      ],
      "Import facts": [
        "팩트 불러오기"
      ],
      "Action with sub plans": [
        "하위 계획이 있는 작업"
      ]
    }
  }
};