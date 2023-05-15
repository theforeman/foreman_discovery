 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['zh_CN'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "FULL NAME <EMAIL@ADDRESS>",
        "Language-Team": "Chinese (China) (http://www.transifex.com/foreman/foreman/language/zh_CN/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "zh_CN",
        "Plural-Forms": "nplurals=1; plural=0;",
        "lang": "zh_CN",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=1; plural=0;"
      },
      "List all discovered hosts": [
        "列出所有发现的主机"
      ],
      "filter results": [
        "过滤结果"
      ],
      "sort results": [
        "排序结果"
      ],
      "paginate results": [
        "分页结果"
      ],
      "number of entries per request": [
        "每个请求的条目数"
      ],
      "Show a discovered host": [
        "显示一个发现主机"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "DHCP 文件名选项（默认为 Grub2 或 PXELinux）"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "创建一个用于测试的发现主机（使用 /详情创建新主机）"
      ],
      "Provision a discovered host": [
        "置备发现主机"
      ],
      "required if host is managed and value is not inherited from host group": [
        "如果主机是受管的，且值没有从主机组继承，则是必需的"
      ],
      "not required if using a subnet with DHCP proxy": [
        "如果使用带有 DHCP 代理的子网则不需要"
      ],
      "not required if it's a virtual machine": [
        "如果是虚拟机，则不需要"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "如果不是基于置备镜像的，主机是受管的，且值没有从主机组继承，则是必需的"
      ],
      "required if host is managed and custom partition has not been defined": [
        "如果已管理主机，且未定义自定义分区，则需填写。"
      ],
      "Host's owner type": [
        "主机所有者类型"
      ],
      "Host's parameters (array or indexed hash)": [
        "主机参数（阵列或索引哈希）"
      ],
      "Name of the parameter": [
        "参数名称"
      ],
      "Parameter value": [
        "参数值"
      ],
      "Type of value": [
        "值类型"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "用于跟踪编配任务状态的 UUID，GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "如果数值不是从主机组或设置中的默认密码继承，则需要。"
      ],
      "Delete a discovered host": [
        "删除发现主机"
      ],
      "Upload facts for a host, creating the host if required": [
        "为主机上传 fact，需要时会创建主机"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "hash 包含具备最小详情集合的主机的详情：discovery_bootif、macaddress_eth0、ipaddress、ipaddress_eth0、interfaces: eth0（主接口名为 eth0 的示例）"
      ],
      "Execute rules against a discovered host": [
        "对发现主机执行规则"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "主机 %{host} 被置备，带有规则 %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "无法置备 %{host}：%{errors}"
      ],
      "No rule found for host %s": [
        "没有为主机 %s 找到规则"
      ],
      "Execute rules against all currently discovered hosts": [
        "对当前所有发现主机执行规则"
      ],
      "Errors during auto provisioning: %s": [
        "自动置备期间出错：%s"
      ],
      "No discovered hosts to provision": [
        "没有要置备的发现主机"
      ],
      "%s discovered hosts were provisioned": [
        "%s 发现的主机被置备"
      ],
      "Refreshing the facts of a discovered host": [
        "刷新发现主机的详情"
      ],
      "Rebooting a discovered host": [
        "重启发现主机"
      ],
      "Rebooting all discovered hosts": [
        "重启所有发现主机"
      ],
      "Discovered hosts are rebooting now": [
        "现在正在重启发现主机"
      ],
      "List all discovery rules": [
        "列出所有发现规则"
      ],
      "Show a discovery rule": [
        "显示一条发现规则"
      ],
      "represents rule name shown to the users": [
        "代表显示给用户的规则名称"
      ],
      "query to match discovered hosts for the particular rule": [
        "与特定规则的发现主机匹配的查询"
      ],
      "the hostgroup that is used to auto provision a host": [
        "用于自动置备主机的主机组"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "定义向匹配主机分配人类可读的主机名称的模式"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "支持根据规则限制置备主机的最大数量"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "按顺序排列规则，低数值优先。必须大于 0"
      ],
      "flag is used for temporary shutdown of rules": [
        "标记用于临时关闭规则"
      ],
      "location ID for provisioned hosts": [
        "预配主机的位置 ID"
      ],
      "organization ID for provisioned hosts": [
        "预配主机的组织 ID"
      ],
      "Create a discovery rule": [
        "创建发现规则"
      ],
      "Update a rule": [
        "更新规则"
      ],
      "Delete a rule": [
        "删除规则"
      ],
      "List all fact values of a given discovered host": [
        "列出给定发现主机的所有系统信息值"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "无法找到发现规则，未提供主机（检查许可）"
      ],
      "No hostgroup associated with rule '%s'": [
        "没有与规则 '%s' 关联的主机组"
      ],
      "Errors during reboot: %s": [
        "重启时出错：%s"
      ],
      "No discovered hosts to reboot": [
        "没有要重启的发现主机"
      ],
      "Successfully provisioned %s": [
        "已成功置备 %s"
      ],
      "Facts refreshed for %s": [
        "%s 的事实已刷新"
      ],
      "Failed to refresh facts for %s": [
        "%s 的事实刷新失败"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "为 %{hostname} 刷新事实失败，错误为 %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "%s 类型的主机不能重启"
      ],
      "Rebooting host %s": [
        "正在重启主机 %s"
      ],
      "Failed to reboot host %s": [
        "重启主机 %s 失败"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "重启主机 %{hostname} 失败，错误为 %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "无法重启主机，错误 %s"
      ],
      "Destroyed selected hosts": [
        "销毁选定的主机"
      ],
      "The following hosts were not deleted: %s": [
        "以下主机没有删除：%s"
      ],
      "Failed to auto provision host %s: %s": [
        "无法自动置备主机 %s：%s"
      ],
      "Discovered hosts are provisioning now": [
        "现在发现主机正在置备"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "从未知子网报告发现的主机，通信数据将不会被代理。"
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "从未知子网报告发现的主机为 %s，通信数据将不会被代理。"
      ],
      "No hosts were found with that id or name": [
        "找不到具有该 ID 或名称的主机"
      ],
      "No hosts selected": [
        "未选择主机"
      ],
      "Something went wrong while selecting hosts - %s": [
        "选择主机时出错 - %s"
      ],
      "Rule enabled": [
        "已启用规则"
      ],
      "Rule disabled": [
        "已禁用规则"
      ],
      "Auto Provision": [
        "自动置备"
      ],
      "Refresh facts": [
        "刷新详情"
      ],
      "Reboot": [
        "重启"
      ],
      "Back": [
        "返回"
      ],
      "Select Action": [
        "选择操作"
      ],
      "Delete %s?": [
        "刪除 %s?"
      ],
      "Assign Organization": [
        "指定机构"
      ],
      "Assign Location": [
        "分配位置"
      ],
      "Delete": [
        "刪除"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - 以下主机即将更改"
      ],
      "N/A": [
        "不适用"
      ],
      "New in the last 24 hours": [
        "在最近 24 小时之内新建"
      ],
      "Not reported in more than 7 days": [
        "没有超过 7 天的报告"
      ],
      "Reported in the last 7 days": [
        "最近 7 天内报告"
      ],
      "Provision": [
        "置备"
      ],
      "Discovered Hosts": [
        "发现主机"
      ],
      "Associated Hosts": [
        "关联主机"
      ],
      "Disable": [
        "禁用"
      ],
      "Disable rule '%s'?": [
        "禁用规则 '%s'？"
      ],
      "Enable": [
        "启用"
      ],
      "Enable rule '%s'?": [
        "启用规则 '%s'？"
      ],
      "Clone": [
        "克隆"
      ],
      "Delete rule '%s'?": [
        "删除规则 '%s'？"
      ],
      "Invalid user type of %s was provided": [
        "提供了无效的 %s 用户类型"
      ],
      "Discovered hosts summary": [
        "发现主机摘要"
      ],
      "can't contain white spaces.": [
        "不能包含空格。"
      ],
      "must start with a letter or ERB.": [
        "必须以字母或 ERB 开始。"
      ],
      "must be present.": [
        "必须存在。"
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "主机组机构 %s 也必须与发现规则关联"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "主机组位置 %s 也必须与发现规则关联"
      ],
      "Fact + prefix": [
        "Fact + 前缀"
      ],
      "Random name": [
        "随机名"
      ],
      "MAC-based name": [
        "基于 MAC 的名称"
      ],
      "Invalid facts, must be a Hash": [
        "无效详情，必须是 Hash"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "缺少期望的 discovery_fact '%s'，无法检测主接口和设置主机名称"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "无效详情：hash 不包含 discovery_hostname 设置中任何详情的有效值：%s"
      ],
      "Facts could not be imported": [
        "无法导入详情"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "无法从代理 %{url} 获得详情：%{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "无法在%{name}（%{url}）上执行重新引导：%{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "无法在 %{ips} 上执行 %{action}"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "无法在 %{name} (%{url}) 上执行 kexec : %{msg}"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "无效的主机名：无法标准化主机名"
      ],
      "Reloading kernel on %s": [
        "正在 %s 上重新加载内核"
      ],
      "Rebooting %s": [
        "重启 %s"
      ],
      "Kexec template not associated with operating system": [
        "Kexec 模板未与操作系统关联"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "内核 kexec URL 无效：'%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "Init RAM kexec URL 无效：'%s'"
      ],
      "Rebuild DNS for %s": [
        "为 %s 重建 DNS"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "发现事实解析器无法在未发现主机 '%{host}' 上工作"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "发现的主机 '%{host}' 的所有 NIC 都被过滤掉，过滤：%{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "无法找到带有通过 '%{fact}' 指定的 '%{mac}' 的主 NIC。NIC 过滤：%{filter}"
      ],
      "Highlights": [
        "亮点"
      ],
      "Storage": [
        "存储"
      ],
      "Hardware": [
        "硬件"
      ],
      "Network": [
        "网络"
      ],
      "Software": [
        "软件"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "杂项"
      ],
      "IPAM must be configured for subnet '%s'": [
        "必须为子网 '%s' 配置 IPAM"
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
        "镜像 API 返回 HTTP/%{code}，带有 '%{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "图片 API 处理错误：%{msg} （HTTP /%{code} ， 内容：%{body} ）"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "主机 %s 已被发现。"
      ],
      "Discovered Host": [
        "发现的主机"
      ],
      "No discovered hosts available": [
        "没有可用的发现主机"
      ],
      "Host": [
        "主机"
      ],
      "Model": [
        "模型"
      ],
      "CPUs": [
        "CPU"
      ],
      "Memory": [
        "内存"
      ],
      "Customize Host": [
        "自定义主机"
      ],
      "Create Host": [
        "创建主机"
      ],
      "Select all items in this page": [
        "选择这个页中的所有项"
      ],
      "items selected. Uncheck to Clear": [
        "选择的项。取消选中以清除"
      ],
      "Name": [
        "名称"
      ],
      "IP Address": [
        "IP 地址"
      ],
      "Disk Count": [
        "磁盘计数"
      ],
      "Disks Size": [
        "磁盘大小"
      ],
      "Location": [
        "位置"
      ],
      "Organization": [
        "机构"
      ],
      "Subnet": [
        "子网"
      ],
      "Last Facts Upload": [
        "最后事实上传"
      ],
      "Actions": [
        "操作"
      ],
      "Please Confirm": [
        "请确认"
      ],
      "Cancel": [
        "取消"
      ],
      "Submit": [
        "提交"
      ],
      "Provision %s": [
        "置备 %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "这可能需要一段时间，因为所有主机，事实和报告也将被销毁。"
      ],
      "Select location": [
        "选择位置"
      ],
      "Select organization": [
        "选择机构"
      ],
      "Discovered host: %s": [
        "发现的主机：%s"
      ],
      "Interfaces": [
        "接口"
      ],
      "Type": [
        "类型"
      ],
      "Identifier": [
        "鉴定"
      ],
      "MAC address": [
        "MAC 地址"
      ],
      "IP address": [
        "IP 地址"
      ],
      "Collapse All": [
        "全部折叠"
      ],
      "Summary report for discovered hosts from Foreman": [
        "来自 Foreman 的 发现主机概述报告"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b> 发现的主机概述"
      ],
      "Summary from %{time} ago to %{now}": [
        "从%{time}以前到 %{now} 的概述"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "来自 %{foreman_url} Foreman 服务器的发现主机"
      ],
      "Disk count": [
        "磁盘计数"
      ],
      "Disks size": [
        "磁盘大小"
      ],
      "No discovered hosts for the selected period": [
        "选定时间段内没有发现主机"
      ],
      "Foreman discovered hosts summary": [
        "Foreman 发现主机概述"
      ],
      "No new discovered hosts for this period": [
        "此时间段内没有新发现主机"
      ],
      "Primary": [
        "主"
      ],
      "Locations": [
        "位置"
      ],
      "Organizations": [
        "机构"
      ],
      "Target host group for this rule with all properties set": [
        "此规则的目标主机组所有属性已设置"
      ],
      "Hostname for provisioned hosts": [
        "置备主机的主机名"
      ],
      "Hosts Limit": [
        "主机限制"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "按照此规则置备的最大主机数（0 = 没有限制）"
      ],
      "Rule priority (lower integer means higher priority)": [
        "规则优先级（整数越小，优先级越高）"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "以与置备模板 (ERB) 中相同的语法指定目标主机名模板模式。"
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "域将自动附加。留空时将使用基于 MAC 地址的主机名。"
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "除了 @host 属性函数之外，还提供随机整数 rand。"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "创建主机名模式时，确保生成的主机名是唯一的。"
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "主机名不得以数字开始。一种好方法是使用 facter 提供的独特信息（MAC 地址、BIOS 或序列 ID）。"
      ],
      "Clone %s": [
        "克隆 %s"
      ],
      "Edit %s": [
        "编辑 %s"
      ],
      "Discovery Rules": [
        "发现规则"
      ],
      "Create Rule": [
        "创建规则"
      ],
      "DiscoveryRule|Name": [
        "DiscoveryRule|Name"
      ],
      "DiscoveryRule|Priority": [
        "发现规则|优先级"
      ],
      "DiscoveryRule|Query": [
        "DiscoveryRule|Query"
      ],
      "Host Group": [
        "主机组"
      ],
      "Hosts/Limit": [
        "主机/限制"
      ],
      "DiscoveryRule|Enabled": [
        "DiscoveryRule|Enabled"
      ],
      "New Discovery Rule": [
        "新建发现规则"
      ],
      "Discovered Rules": [
        "发现规则"
      ],
      "A summary of discovered hosts": [
        "发现主机概述"
      ],
      "New hosts": [
        "新主机"
      ],
      "One or more hosts have been discovered": [
        "已发现一个或多个主机"
      ],
      "Details": [
        "详情"
      ],
      "Hosts": [
        "主机"
      ],
      "Error message goes here": [
        "错误信息到这里"
      ],
      "Discovery": [
        "发现"
      ],
      "Discovery location": [
        "发现位置"
      ],
      "The default location to place discovered hosts in": [
        "放置发现主机的默认位置"
      ],
      "Discovery organization": [
        "发现机构"
      ],
      "The default organization to place discovered hosts in": [
        "放置发现主机的默认机构"
      ],
      "Interface fact": [
        "接口详情"
      ],
      "Fact name to use for primary interface detection": [
        "用于主接口检测的详情名称"
      ],
      "Create bond interfaces": [
        "创建绑定接口"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "自动绑定接口（如果通过 LLDP 在同一个 VLAN 中发现另外一个接口）"
      ],
      "Clean all facts": [
        "清除所有详情"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "置备期间清除所有报告的详情（发现详情除外）"
      ],
      "Hostname facts": [
        "主机名详情"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "自动置备"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "根据置备规则，自动置备新发现主机"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "置备期间自动重启或 kexec 发现主机"
      ],
      "Hostname prefix": [
        "主机名前缀"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "使用的主机名默认前缀必须以字母开头"
      ],
      "Fact columns": [
        "详情列"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "高亮详情"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "组织高亮部分详情的正则表达式 - 例如 ^(abc|cde)$"
      ],
      "Storage facts": [
        "存储详情"
      ],
      "Regex to organize facts for storage section": [
        "组织存储部分详情的正则表达式"
      ],
      "Software facts": [
        "软件详情"
      ],
      "Regex to organize facts for software section": [
        "组织软件部分详情的正则表达式"
      ],
      "Hardware facts": [
        "硬件详情"
      ],
      "Regex to organize facts for hardware section": [
        "组织硬件部分详情的正则表达式"
      ],
      "Network facts": [
        "网络详情"
      ],
      "Regex to organize facts for network section": [
        "组织网络部分详情的正则表达式"
      ],
      "IPMI facts": [
        "IPMI 详情"
      ],
      "Regex to organize facts for ipmi section": [
        "组织 ipmi 部分详情的正则表达式"
      ],
      "Lock PXE": [
        "锁定 PXE"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "自动生成 PXE 配置，以将新发现主机固定至发现"
      ],
      "Locked PXELinux template name": [
        "锁定的 PXELinux 模板名称"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "将主机固定至发现时使用的 PXELinux 模板"
      ],
      "Locked PXEGrub template name": [
        "锁定的 PXEGrub 模板名称"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "将主机固定至发现时使用的 PXEGrub 模板"
      ],
      "Locked PXEGrub2 template name": [
        "锁定的 PXEGrub2 模板名称"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "将主机固定至发现时使用的 PXEGrub2 模板"
      ],
      "Force DNS": [
        "强制 DNS"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "置备发现主机时强制 DNS 条目创建"
      ],
      "Error on existing NIC": [
        "已存在的 NIC 上的错误"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "不允许发现匹配一个置备 NIC 的 MAC 的已存在的管理的主机（早期出现错误）"
      ],
      "Type of name generator": [
        "名称生成器类型"
      ],
      "Discovery hostname naming pattern": [
        "发现主机名的名称特征"
      ],
      "Prefer IPv6": [
        "首选使用 IPv6"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "在调用发现节点时，首选 IPv6 而不是 IPv4"
      ],
      "Discovery Proxy": [
        "发现代理服务器"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "本子网内用于管理到发现主机的连接的发现代理服务器"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "本子网内用于管理到发现主机的连接的发现代理服务器 ID"
      ],
      "For more information please see ": [
        "查看详情 "
      ],
      "documentation": [
        "文档"
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        "此上下文中未找到发现的主机。此页显示了等待置备的发现裸机或虚拟节点。"
      ],
      "Foreman Discovery": [
        ""
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        "在此上下文中没有发现规则。创建发现规则以在发现的主机上执行自动化调配"
      ],
      "Remote action:": [
        "远程操作："
      ],
      "Import Puppet classes": [
        "导入 Puppet 类"
      ],
      "Import facts": [
        "导入事实"
      ],
      "Action with sub plans": [
        "有子计划的操作"
      ]
    }
  }
};