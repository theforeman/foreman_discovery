 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['ko'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery 25.1.0",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Ewoud Kohl van Wijngaarden <ewoud+transifex@kohlvanwijngaarden.nl>, 2022",
        "Language-Team": "Korean (http://app.transifex.com/foreman/foreman/language/ko/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "ko",
        "Plural-Forms": "nplurals=1; plural=0;",
        "lang": "ko",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=1; plural=0;"
      },
      "%s - The following hosts are about to be changed": [
        "%s - 다음 호스트는 즉시 변경됩니다"
      ],
      "%s discovered hosts were provisioned": [
        "%s개의 검색된 호스트를 프로비저닝했습니다."
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b>에서 검색된 호스트 요약"
      ],
      "A summary of discovered hosts": [
        "검색된 호스트 요약"
      ],
      "Actions": [
        "동작 "
      ],
      "Assign Location": [
        "위치 지정"
      ],
      "Assign Organization": [
        "조직 지정"
      ],
      "Associated Hosts": [
        "연관된 호스트"
      ],
      "Auto Provision": [
        "자동 프로비저닝"
      ],
      "Auto provisioning": [
        "자동 프로비저닝"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "자동 본드 인터페이스(LLDP를 통해 동일한 VLAN에서 다른 인터페이스가 감지되는 경우)"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "새로 검색된 호스트를 검색에 고정하기 위해 PXE 구성을 자동으로 생성합니다."
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "프로비저닝 규칙에 따라 새로 검색된 호스트의 자동 프로비저닝"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "프로비저닝 중에 자동으로 재부팅하거나 kexec에서 발견된 호스트"
      ],
      "Back": [
        "뒤로 "
      ],
      "CPUs": [
        "CPU"
      ],
      "Cancel": [
        "취소 "
      ],
      "Clean all facts": [
        "모든 팩트 정리"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "프로비저닝 중 보고된 모든 팩트 정리(검색된 팩트 제외)"
      ],
      "Clone": [
        "복제(Clone)"
      ],
      "Clone %s": [
        "%s 복제"
      ],
      "Collapse All": [
        "모두 축소"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "프록시 %{url}에서 팩트를 가져올 수 없습니다: %{error}"
      ],
      "Create Host": [
        "호스트 생성"
      ],
      "Create Rule": [
        "규칙 생성"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "검색된 호스트를 테스트용으로 생성(/facts를 사용하여 새 호스트 생성)"
      ],
      "Create a discovery rule": [
        "검색 규칙 생성"
      ],
      "Create bond interfaces": [
        "본드 인터페이스 생성"
      ],
      "Customize Host": [
        "호스트 사용자 정의"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "DHCP 파일 이름 옵션(기본적으로 Grub2 또는 PXELinux)"
      ],
      "Delete": [
        "삭제 "
      ],
      "Delete %s?": [
        "%s 을(를) 삭제하시겠습니까?"
      ],
      "Delete a discovered host": [
        "검색된 호스트 삭제"
      ],
      "Delete a rule": [
        "규칙 삭제"
      ],
      "Delete rule '%s'?": [
        "규칙 '%s'을 삭제하시겠습니까?"
      ],
      "Destroyed selected hosts": [
        "선택된 호스트 삭제"
      ],
      "Details": [
        "상세 정보 "
      ],
      "Disable": [
        "비활성화 "
      ],
      "Disable rule '%s'?": [
        "규칙 '%s'을/를 비활성화하시겠습니까?"
      ],
      "Discovered Host": [
        "검색된 호스트"
      ],
      "Discovered Hosts": [
        "발견된 호스트"
      ],
      "Discovered Rules": [
        "검색된 규칙"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "검색 호스트 '%{host}'에서 모든 NIC가 필터링되었습니다. 필터: %{filter}"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "알 수 없는 서브넷에서 보고된 호스트가 발견되어 통신이 프록시되지 않습니다."
      ],
      "Discovered host: %s": [
        "검색된 호스트: %s"
      ],
      "Discovered hosts are provisioning now": [
        "현재 검색된 호스트를 프로비저닝하고 있습니다"
      ],
      "Discovered hosts are rebooting now": [
        "현재 검색된 호스트를 재부팅하고 있습니다."
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "%{foreman_url}에 Foreman 서버에서 호스트를 발견했습니다."
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "알 수 없는 서브넷에서 보고된 검색된 호스트는 %s이고 통신은 프록시되지 않습니다."
      ],
      "Discovered hosts summary": [
        "검색된 호스트 요약"
      ],
      "Discovery": [
        "검색"
      ],
      "Discovery Proxy": [
        "검색 프록시"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "이 서브넷 내에서 검색된 호스트에 대한 연결을 관리하는 데 사용할 검색 프록시"
      ],
      "Discovery Rules": [
        "검색 규칙"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "검색 팩트 분석은 감지되지 않은 호스트 '%{host}'에서 작동하지 않습니다."
      ],
      "Discovery hostname naming pattern": [
        "검색 호스트 이름 명명 패턴"
      ],
      "Discovery location": [
        "검색 장소"
      ],
      "Discovery organization": [
        "검색 조직"
      ],
      "DiscoveryRule|Enabled": [
        "활성화"
      ],
      "DiscoveryRule|Name": [
        "이름"
      ],
      "DiscoveryRule|Priority": [
        "우선 순위"
      ],
      "DiscoveryRule|Query": [
        "쿼리"
      ],
      "Disk Count": [
        "디스크 수"
      ],
      "Disk count": [
        "디스크 수"
      ],
      "Disks Size": [
        "디스크 크기"
      ],
      "Disks size": [
        "디스크 크기"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "프로비저닝 NIC의 MAC과 일치하는 기존 관리 호스트를 검색할 수 없습니다(오류가 초기에 발생함)"
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "도메인은 자동으로 추가됩니다. 비어 있으면 MAC 주소 기반 호스트 이름이 사용됩니다."
      ],
      "Edit %s": [
        "%s 편집 "
      ],
      "Enable": [
        "활성화 "
      ],
      "Enable rule '%s'?": [
        "규칙 '%s'을/를 활성화하시겠습니까?"
      ],
      "Error message goes here": [
        "오류 메시지는 여기에 표시됩니다."
      ],
      "Error on existing NIC": [
        "기존 NIC의 오류"
      ],
      "Errors during auto provisioning: %s": [
        "자동 프로비저닝 도중 오류 발생: %s"
      ],
      "Errors during reboot: %s": [
        "재부팅 도중 오류가 발생했습니다: %s"
      ],
      "Execute rules against a discovered host": [
        "검색된 호스트에 대해 규칙 실행"
      ],
      "Execute rules against all currently discovered hosts": [
        "현재 검색된 모든 호스트에 대해 규칙 실행"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "필요한 discovery_fact '%s'이(가) 누락되었습니다. 기본 인터페이스와 설정된 호스트 이름을 감지할 수 없습니다."
      ],
      "Extra facter columns to show in host lists": [
        "호스트 목록에 표시할 추가 팩터 열"
      ],
      "Fact + prefix": [
        "팩트 + 접두사"
      ],
      "Fact columns": [
        "팩트 칼럼"
      ],
      "Fact name to use for primary interface detection": [
        "기본 인터페이스 감지에 사용할 팩트 이름"
      ],
      "Facts could not be imported": [
        "팩트를 가져올 수 없습니다."
      ],
      "Facts refreshed for %s": [
        "%s에 대해 업데이트된 팩트"
      ],
      "Failed to auto provision host %s: %s": [
        "호스트 %s의 자동 프로비저닝에 실패했습니다: %s"
      ],
      "Failed to reboot host %s": [
        "호스트 %s 재부팅에 실패했습니다"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "오류 %{error_message}를 표시하는 호스트 %{hostname} 재부팅에 실패했습니다"
      ],
      "Failed to reboot hosts with error %s": [
        "%s 오류가 발생하여 호스트를 재부팅하지 못했습니다."
      ],
      "Failed to refresh facts for %s": [
        "%s에 대한 팩트를 새로고침하는데 실패했습니다"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "%{error_message} 오류가 발생하여 %{hostname}의 팩트를 새로 고치지 못했습니다."
      ],
      "For more information please see ": [
        "자세한 내용은 다음을 참조하세요. "
      ],
      "Force DNS": [
        "DNS 강제 실행"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "검색된 호스트를 프로비저닝할 때 강제 DNS 항목 생성"
      ],
      "Foreman Discovery": [
        "Foreman 검색"
      ],
      "Foreman discovered hosts summary": [
        "Foreman에서 검색된 호스트 요약"
      ],
      "Hardware": [
        "하드웨어"
      ],
      "Hardware facts": [
        "하드웨어 팩트"
      ],
      "Highlighted facts": [
        "강조된 팩트"
      ],
      "Highlights": [
        "하이라이트"
      ],
      "Host": [
        "호스트 "
      ],
      "Host %s has been dicovered": [
        "호스트 %s이/가 감지되었습니다"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "호스트 %{host}은/는 %{rule}으(로) 프로비저닝됩니다"
      ],
      "Host Group": [
        "호스트 그룹"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "호스트 그룹 위치%s 또한 검색 규칙과 연관되어야 합니다."
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "호스트 그룹 조직%s 또한 검색 규칙과 연관되어야 합니다."
      ],
      "Host of type %s can not be rebooted": [
        "호스트 유형 %s은(는) 재부팅할 수 없습니다"
      ],
      "Host's owner type": [
        "호스트의 소유자 유형"
      ],
      "Host's parameters (array or indexed hash)": [
        "호스트의 매개 변수(배열 또는 인덱싱된 해시)"
      ],
      "Hostname facts": [
        "호스트 이름 팩트"
      ],
      "Hostname for provisioned hosts": [
        "프로비저닝된 호스트의 호스트 이름"
      ],
      "Hostname prefix": [
        "호스트 이름 접두사"
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "호스트 이름은 숫자로 시작할 수 없습니다. 좋은 방법은 팩터에서 제공하는 고유 정보(MAC 주소, BIOS 또는 일련 번호)를 사용하는 것입니다."
      ],
      "Hosts": [
        "호스트"
      ],
      "Hosts Limit": [
        "호스트 제한"
      ],
      "Hosts/Limit": [
        "호스트/제한"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "이 서브넷 내에서 검색된 호스트에 대한 연결을 관리하는 데 사용할 검색 프록시의 ID"
      ],
      "IP Address": [
        "IP 주소"
      ],
      "IPAM must be configured for subnet '%s'": [
        "IPAM은 서브넷 '%s'에 대해 구성되어야 합니다."
      ],
      "IPMI": [
        "IPMI"
      ],
      "IPMI facts": [
        "IPMI 팩트"
      ],
      "IPv4": [
        ""
      ],
      "IPv6": [
        ""
      ],
      "Identifier": [
        "식별자"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "이미지 API 처리 오류: %{msg}(HTTP/%{code}, 본문: %{body})"
      ],
      "Image API returned HTTP/%{code} with '%{body}": [
        "이미지 API에서 '%{body}'이(가) 포함된 HTTP/%{code}을(를) 반환했습니다."
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "@host 속성 외에도 임의의 정수를 생성하는 rand 함수를 사용할 수 있습니다. 예:"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "Init RAM kexec URL이 잘못되었습니다: '%s '"
      ],
      "Interface fact": [
        "인터페이스 팩트"
      ],
      "Interfaces": [
        "인터페이스"
      ],
      "Invalid facts, must be a Hash": [
        "잘못된 팩트, 해시여야 합니다"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "잘못된 사실: 해시에 discovery_hostname 설정의 팩트에 대해서도 유효한 값이 없습니다. %s"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "잘못된 호스트 이름: 호스트 이름을 정규화할 수 없습니다."
      ],
      "Invalid user type of %s was provided": [
        "잘못된 사용자 유형%s이/가 지정되었습니다"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "커널 kexec URL이 잘못되었습니다: '%s '"
      ],
      "Kexec template not associated with operating system": [
        "Kexec 템플릿이 운영 체제에 연결되어 있지 않습니다."
      ],
      "Last Facts Upload": [
        "최근 팩트 업로드"
      ],
      "List all discovered hosts": [
        "검색된 모든 호스트를 나열"
      ],
      "List all discovery rules": [
        "모든 검색 규칙을 나열"
      ],
      "List all fact values of a given discovered host": [
        "검색된 호스트의 모든 팩트 값을 나열합니다."
      ],
      "List of facts to use for the hostname (first wins)": [
        "호스트 이름에 사용할 팩트 목록 (first wins)"
      ],
      "Location": [
        "위치"
      ],
      "Locations": [
        "위치"
      ],
      "Lock PXE": [
        "PXE 잠금"
      ],
      "Locked PXEGrub template name": [
        "잠긴 PXEGrub 템플릿 이름"
      ],
      "Locked PXEGrub2 template name": [
        "잠긴 PXEGrub2 템플릿 이름"
      ],
      "Locked PXELinux template name": [
        "잠긴 PXELinux 템플릿 이름"
      ],
      "MAC address": [
        "MAC 주소"
      ],
      "MAC-based name": [
        "MAC 기반 이름"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "이 규칙에서 프로비저닝되는 최대 호스트 수 (0 = 무제한)"
      ],
      "Memory": [
        "메모리"
      ],
      "Miscellaneous": [
        "기타"
      ],
      "Model": [
        "모델 "
      ],
      "N/A": [
        "해당 없음 "
      ],
      "Name": [
        "이름 "
      ],
      "Name of the parameter": [
        "매개 변수의 이름"
      ],
      "Network": [
        "네트워크"
      ],
      "Network facts": [
        "네트워크 팩트"
      ],
      "New Discovery Rule": [
        "새 검색 규칙"
      ],
      "New hosts": [
        "새로운 호스트"
      ],
      "New in the last 24 hours": [
        "지난 24시간 이내의 신규 항목"
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        "이 컨텍스트에서 발견된 검색 규칙이 없습니다. 검색된 호스트에서 자동 프로비저닝을 수행하기 위한 검색 규칙을 만듭니다."
      ],
      "No discovered hosts available": [
        "사용 가능한 검색된 호스트가 없습니다"
      ],
      "No discovered hosts for the selected period": [
        "선택한 기간 동안 호스트가 검색되지 않았습니다."
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        "이 컨텍스트에서 검색된 호스트가 없습니다. 이 페이지는 프로비저닝을 기다리는 베어 메탈 또는 가상 노드를 보여줍니다."
      ],
      "No discovered hosts to provision": [
        "프로비저닝할 검색된 호스트가 없습니다"
      ],
      "No discovered hosts to reboot": [
        "재부팅할 검색된 호스트가 없습니다."
      ],
      "No hostgroup associated with rule '%s'": [
        "'%s' 규칙에 연결된 호스트 그룹이 없습니다."
      ],
      "No hosts selected": [
        "선택된 호스트가 없음"
      ],
      "No hosts were found with that id or name": [
        "해당 ID 또는 이름의 호스트를 찾을 수 없습니다"
      ],
      "No new discovered hosts for this period": [
        "이 기간 동안 새로 검색된 호스트가 없습니다."
      ],
      "No rule found for host %s": [
        "호스트 %s에 대한 규칙을 찾을 수 없습니다"
      ],
      "Not reported in more than 7 days": [
        "7일 넘게 보고되지 않음"
      ],
      "One or more hosts have been discovered": [
        "하나 이상의 호스트가 발견되었습니다"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        "오류로 인해 하나 이상의 호스트를 찾지 못했습니다: %s"
      ],
      "Option 'url' must be provided": [
        "옵션 'url'을 제공해야 합니다."
      ],
      "Option 'url' must be valid URI: %s": [
        "옵션 'url'은 유효한 URI여야 합니다. %s"
      ],
      "Options must be hash": [
        "옵션은 해시여야 합니다."
      ],
      "Organization": [
        "조직 "
      ],
      "Organizations": [
        "조직"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "호스트를 검색에 고정할 때 사용할 PXEGrub 템플릿"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "호스트를 검색에 고정할 때 사용할 PXEGrub2 템플릿"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "호스트를 검색에 고정할 때 사용할 PXELinux 템플릿"
      ],
      "Parameter value": [
        "매개 변수 값"
      ],
      "Please Confirm": [
        "확인해 주십시오"
      ],
      "Prefer IPv6": [
        "IPv6 우선 순위"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "검색된 노드를 호출할 때 IPv4보다 IPv6을 우선합니다."
      ],
      "Primary": [
        "주"
      ],
      "Provision": [
        "프로비저닝"
      ],
      "Provision %s": [
        "프로비저닝 %s"
      ],
      "Provision a discovered host": [
        "검색된 호스트 프로비저닝"
      ],
      "Random name": [
        "무작위 이름"
      ],
      "Reboot": [
        "다시 시작"
      ],
      "Rebooting %s": [
        "%s 재부팅 중"
      ],
      "Rebooting a discovered host": [
        "검색된 호스트를 재부팅 중"
      ],
      "Rebooting all discovered hosts": [
        "검색된 모든 호스트를 재부팅 중"
      ],
      "Rebooting host %s": [
        "호스트 %s 재부팅 중"
      ],
      "Rebuild DNS for %s": [
        "%s의 DNS를 다시 빌드합니다"
      ],
      "Refresh facts": [
        "팩트 새로고침"
      ],
      "Refreshing the facts of a discovered host": [
        "검색된 호스트의 팩트를 새로고침 중"
      ],
      "Regex to organize facts for hardware section": [
        "하드웨어 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "하이라이트 섹션의 팩트를 구성하는 정규식 - 예: ^(abc|cde)$"
      ],
      "Regex to organize facts for ipmi section": [
        "ipmi 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Regex to organize facts for network section": [
        "네트워크 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Regex to organize facts for software section": [
        "소프트웨어 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Regex to organize facts for storage section": [
        "스토리지 섹션의 팩트를 구성하기 위한 정규식"
      ],
      "Reloading kernel on %s": [
        "%s에서 커널을 다시 로드하는 중"
      ],
      "Reported in the last 7 days": [
        "지난 7일 이내에 보고됨"
      ],
      "Rule disabled": [
        "규칙 비활성화"
      ],
      "Rule enabled": [
        "규칙 비활성화"
      ],
      "Rule priority (lower integer means higher priority)": [
        "규칙 우선 순위 (낮은 정수 값일수록 우선 순위가 높아짐)"
      ],
      "Select Action": [
        "작업 선택"
      ],
      "Select all items in this page": [
        "이 페이지에 있는 모든 항목을 선택"
      ],
      "Select location": [
        "위치 선택"
      ],
      "Select organization": [
        "조직 선택"
      ],
      "Show a discovered host": [
        "검색된 호스트 표시"
      ],
      "Show a discovery rule": [
        "검색 규칙 표시"
      ],
      "Software": [
        "소프트웨어"
      ],
      "Software facts": [
        "소프트웨어 팩트"
      ],
      "Something went wrong while selecting hosts - %s": [
        "호스트를 선택하는 도중 문제가 발생했습니다 - %s"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "프로비저닝 템플릿 (ERB)에 있는 것과 동일한 구문의 대상 호스트 이름 템플릿 패턴을 지정합니다."
      ],
      "Storage": [
        "스토리지"
      ],
      "Storage facts": [
        "스토리지 팩트"
      ],
      "Submit": [
        "보내기"
      ],
      "Subnet": [
        "서브넷"
      ],
      "Successfully provisioned %s": [
        "성공적으로 프로비저닝되었습니다 %s"
      ],
      "Summary from %{time} ago to %{now}": [
        "%{time}부터 %{now}까지 요약"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Foreman에서 검색된 호스트에 대한 요약 보고서"
      ],
      "Target host group for this rule with all properties set": [
        "모든 속성 모음을 갖는 규칙의 대상 호스트 그룹"
      ],
      "The default location to place discovered hosts in": [
        "검색된 호스트를 배치하기 위한 기본 위치"
      ],
      "The default organization to place discovered hosts in": [
        "검색된 호스트를 배치하기 위한 기본 조직"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "호스트 이름에 사용할 기본 접두사는 문자로 시작해야 합니다"
      ],
      "The following hosts were not deleted: %s": [
        "다음 호스트가 삭제되지 않았습니다: %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "모든 호스트, 팩트, 보고서가 모두 삭제되기 때문에 시간이 걸릴 수 있습니다"
      ],
      "Type": [
        "유형 "
      ],
      "Type of name generator": [
        "이름 생성기 유형"
      ],
      "Type of value": [
        "값의 유형"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "오케스트레이션 작업 상태를 추적하기 위한 UUID, GET /api/orchestration/:UUID/tasks"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "검색 규칙을 찾을 수 없습니다. 호스트가 제공되지 않았습니다(권한 확인)."
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "'%{fact}'를 통해 지정된 %{mac}로 기본 NIC를 찾을 수 없습니다. NIC 필터: %{filter}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "%{ips}에서 %{action}을/를 실행할 수 없습니다"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "%{name} (%{url})에서 kexec를 실행할 수 없습니다: %{msg}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "%{name} (%{url})에서 재부팅을 실행할 수 없습니다: %{msg}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "%{host}을(를) 프로비저닝할 수 없습니다: %{errors}"
      ],
      "Update a rule": [
        "규칙 업데이트"
      ],
      "Upload facts for a host, creating the host if required": [
        "호스트의 팩트를 업로드하고 필요한 경우 호스트를 생성합니다"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "호스트 이름 패턴을 생성할 때 생성되는 호스트 이름이 고유한지 확인하세요."
      ],
      "can't contain white spaces.": [
        "공백을 포함할 수 없습니다."
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "해당 호스트에 읽기 좋은 호스트 이름을 할당하기 위해 패턴을 정의합니다"
      ],
      "documentation": [
        "문서"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "규칙 당 프로비저닝된 호스트의 최대 수량을 제한할 수 있게 합니다"
      ],
      "filter results": [
        "필터 결과"
      ],
      "flag is used for temporary shutdown of rules": [
        "규칙의 일시 정지에 플래그를 사용합니다"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "최소 세트의 팩트가 있는 호스트의 팩트가 포함된 해시: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, 인터페이스: eth0(기본 인터페이스의 이름이 eth0인 경우의 예)"
      ],
      "items selected. Uncheck to Clear": [
        "항목이 선택되어 있습니다. 삭제하려면 선택 해제합니다"
      ],
      "location ID for provisioned hosts": [
        "프로비저닝된 호스트의 위치 ID"
      ],
      "must be present.": [
        "반드시 존재해야 합니다."
      ],
      "must start with a letter or ERB.": [
        "문자 또는 ERB로 시작해야 합니다."
      ],
      "not required if it's a virtual machine": [
        "가상 머신의 경우 필요하지 않습니다"
      ],
      "not required if using a subnet with DHCP proxy": [
        "DHCP 프록시를 갖는 서브넷을 사용할 필요가 없습니다"
      ],
      "not required if using an IPv6 subnet with DHCP proxy": [
        ""
      ],
      "number of entries per request": [
        "요청 당 항목 수"
      ],
      "organization ID for provisioned hosts": [
        "프로비저닝된 호스트의 조직 ID"
      ],
      "paginate results": [
        "페이지네이션 결과"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "규칙을 순서대로 배치합니다. 낮은 숫자를 먼저 배치합니다. 수치는 0 보다 커야 합니다"
      ],
      "query to match discovered hosts for the particular rule": [
        "특정 규칙에 대해 검색된 호스트와 일치하는 쿼리"
      ],
      "represents rule name shown to the users": [
        "사용자에게 표시되는 규칙 이름을 표시합니다"
      ],
      "required if host is managed and custom partition has not been defined": [
        "호스트가 관리되고 있으며 사용자 정의 파티션이 정의되고 있지 않은 경우에 필요합니다"
      ],
      "required if host is managed and value is not inherited from host group": [
        "호스트가 관리되고 있으며 값이 호스트 그룹에서 상속되지 않은 경우에 필요합니다"
      ],
      "required if host is managed, does not have IPv4 IP / Subnet, or the value is not inherited from the host group": [
        ""
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "이미지 기반의 프로비저닝이 아니고 호스트가 관리되어 값이 호스트 그룹에서 상속되지 않은 경우에 필요합니다"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "값이 호스트 그룹이나 설정의 기본값 암호에서 상속되지 않은 경우에 필요합니다"
      ],
      "sort results": [
        "결과 정렬"
      ],
      "the hostgroup that is used to auto provision a host": [
        "호스트를 자동 프로비저닝하기 위해 사용되는 호스트 그룹"
      ]
    }
  }
};