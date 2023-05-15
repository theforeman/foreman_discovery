 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['ja'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "山田 修司 🍣 Shuji Yamada <uzy.exe@gmail.com>, 2015",
        "Language-Team": "Japanese (http://www.transifex.com/foreman/foreman/language/ja/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "ja",
        "Plural-Forms": "nplurals=1; plural=0;",
        "lang": "ja",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=1; plural=0;"
      },
      "List all discovered hosts": [
        "すべての検出されたホストを一覧表示"
      ],
      "filter results": [
        "結果のフィルタリング"
      ],
      "sort results": [
        "結果のソート"
      ],
      "paginate results": [
        "結果のページネーション"
      ],
      "number of entries per request": [
        "要求ごとのエントリー数"
      ],
      "Show a discovered host": [
        "検出されたホストの表示"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "DHCP ファイル名オプション (デフォルトでは Grub2 または PXELinux)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "(新規ホストを作成するための使用 /ファクト) をテストするために検出ホストを作成します"
      ],
      "Provision a discovered host": [
        "検出されたホストのプロビジョニング"
      ],
      "required if host is managed and value is not inherited from host group": [
        "ホストが管理されており、値がホストグループから継承されていない場合に必須です"
      ],
      "not required if using a subnet with DHCP proxy": [
        "DHCP プロキシーでサブネットを使用する場合は不要"
      ],
      "not required if it's a virtual machine": [
        "仮想マシンの場合は不要です"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "イメージベースのプロビジョニングでない場合で、ホストが管理されており、値がホストグループから継承されていない場合に必須です"
      ],
      "required if host is managed and custom partition has not been defined": [
        "ホストが管理されており、カスタムパーティションが定義されていない場合に必須です。"
      ],
      "Host's owner type": [
        "ホストの所有者タイプ"
      ],
      "Host's parameters (array or indexed hash)": [
        "ホストのパラメーター (配列またはインデックス化されたハッシュ)"
      ],
      "Name of the parameter": [
        "パラメーター名"
      ],
      "Parameter value": [
        "パラメーター値"
      ],
      "Type of value": [
        "値のタイプ"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "オーケストレーションタスクのステータスを追跡するための UUID。GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "値がホストグループまたは設定のデフォルトパスワードから継承されていない場合は必須です"
      ],
      "Delete a discovered host": [
        "検出されたホストの削除"
      ],
      "Upload facts for a host, creating the host if required": [
        "ホストのファクトをアップロードし、必要な場合はホストを作成します"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "ファクトの最小セットが設定されたホストのファクトを含むハッシュ : discovery_bootif、macaddress_eth0、ipaddress、ipaddress_eth0、interfaces: eth0 (プライマリーインターフェースの名前が eth0 の場合の例)"
      ],
      "Execute rules against a discovered host": [
        "検出されたホストに対するルールの実行"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "ホスト %{host} がルール %{rule} でプロビジョニングされています"
      ],
      "Unable to provision %{host}: %{errors}": [
        "%{host} をプロビジョニングできません: %{errors}"
      ],
      "No rule found for host %s": [
        "ホスト %s に対するルールは見つかりません"
      ],
      "Execute rules against all currently discovered hosts": [
        "現在検出されているすべてのホストに対するルールの実行"
      ],
      "Errors during auto provisioning: %s": [
        "自動プロビジョニング時のエラー: %s"
      ],
      "No discovered hosts to provision": [
        "プロビジョニングする検出されたホストがありません"
      ],
      "%s discovered hosts were provisioned": [
        "検出ホスト %s 台がプロビジョニングされました"
      ],
      "Refreshing the facts of a discovered host": [
        "検出されたホストのファクトの更新中"
      ],
      "Rebooting a discovered host": [
        "検出されたホストの再起動中"
      ],
      "Rebooting all discovered hosts": [
        "すべての検出されたホストの再起動中"
      ],
      "Discovered hosts are rebooting now": [
        "検出されたホストを現在再起動中"
      ],
      "List all discovery rules": [
        "すべての検出ルールを一覧表示"
      ],
      "Show a discovery rule": [
        "検出ルールの表示"
      ],
      "represents rule name shown to the users": [
        "ユーザーに表示されるルール名を表します"
      ],
      "query to match discovered hosts for the particular rule": [
        "特定ルールの検出されたホストに一致するクエリー"
      ],
      "the hostgroup that is used to auto provision a host": [
        "ホストの自動プロビジョニングに使用されるホストグループ"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "人が判読できるホスト名を一致するホストに割り当てるパターンの定義"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "ルール別のプロビジョニングされたホストの最大数の制限を許可"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "ルールを低い数字の順に配置。ゼロより大きい値である必要があります"
      ],
      "flag is used for temporary shutdown of rules": [
        "フラグはルールの一時的な停止に使用されます"
      ],
      "location ID for provisioned hosts": [
        "プロビジョニングされたホストのロケーション ID"
      ],
      "organization ID for provisioned hosts": [
        "プロビジョニングされたホストの組織 ID"
      ],
      "Create a discovery rule": [
        "検出ルールの作成"
      ],
      "Update a rule": [
        "ルールの更新"
      ],
      "Delete a rule": [
        "ルールの削除"
      ],
      "List all fact values of a given discovered host": [
        "指定の検出されたホストのすべての値を一覧表示"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "検出ルールを見つけることができません。指定されるホストがありません (パーミッションを確認してください)"
      ],
      "No hostgroup associated with rule '%s'": [
        "ルール '%s' に関連付けられたホストグループがありません"
      ],
      "Errors during reboot: %s": [
        "再起動時のエラー: %s"
      ],
      "No discovered hosts to reboot": [
        "再起動する検出されたホストがありません"
      ],
      "Successfully provisioned %s": [
        "%s が正常にプロビジョニングされました"
      ],
      "Facts refreshed for %s": [
        "%s の更新済みファクト"
      ],
      "Failed to refresh facts for %s": [
        "%s のファクトの更新に失敗しました"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "%{error_message} エラーで %{hostname} のファクトの更新に失敗しました"
      ],
      "Host of type %s can not be rebooted": [
        "タイプ %s のホストを再起動できません"
      ],
      "Rebooting host %s": [
        "ホスト %s の再起動"
      ],
      "Failed to reboot host %s": [
        "ホスト %s の再起動に失敗しました"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "ホスト %{hostname} は %{error_message} のエラーで再起動に失敗しました"
      ],
      "Failed to reboot hosts with error %s": [
        "ホストは %s のエラーで再起動に失敗しました"
      ],
      "Destroyed selected hosts": [
        "破棄された選択済みホスト"
      ],
      "The following hosts were not deleted: %s": [
        "以下のホストは削除されませんでした: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "ホスト %s の自動プロビジョニングに失敗しました: %s"
      ],
      "Discovered hosts are provisioning now": [
        "検出されたホストは現在プロビジョニング中です"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "不明なサブネットから報告された検出されたホスト。通信はプロキシー化されません。"
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "不明なサブネットから報告された検出されたホストは %s、通信はプロキシー化されません。"
      ],
      "No hosts were found with that id or name": [
        "該当する ID または名前のホストが見つかりませんでした"
      ],
      "No hosts selected": [
        "ホストが選択されていません"
      ],
      "Something went wrong while selecting hosts - %s": [
        "ホストの選択中に問題が発生しました: %s"
      ],
      "Rule enabled": [
        "ルールが有効にされました"
      ],
      "Rule disabled": [
        "ルールが無効にされました"
      ],
      "Auto Provision": [
        "自動プロビジョニング"
      ],
      "Refresh facts": [
        "ファクトの更新"
      ],
      "Reboot": [
        "再起動"
      ],
      "Back": [
        "戻る"
      ],
      "Select Action": [
        "アクションの選択"
      ],
      "Delete %s?": [
        "%s を削除しますか?"
      ],
      "Assign Organization": [
        "組織の割り当て"
      ],
      "Assign Location": [
        "ロケーションの割り当て"
      ],
      "Delete": [
        "削除"
      ],
      "%s - The following hosts are about to be changed": [
        "%s: 以下のホストはまもなく変更されます"
      ],
      "N/A": [
        "N/A"
      ],
      "New in the last 24 hours": [
        "過去 24 時間以内の新規"
      ],
      "Not reported in more than 7 days": [
        "8 日以上報告なし"
      ],
      "Reported in the last 7 days": [
        "過去 7 日以内に報告あり"
      ],
      "Provision": [
        "プロビジョニング"
      ],
      "Discovered Hosts": [
        "検出されたホスト"
      ],
      "Associated Hosts": [
        "関連付けられたホスト"
      ],
      "Disable": [
        "無効化"
      ],
      "Disable rule '%s'?": [
        "ルール '%s' を無効にしますか?"
      ],
      "Enable": [
        "有効化"
      ],
      "Enable rule '%s'?": [
        "ルール '%s' を有効にしますか?"
      ],
      "Clone": [
        "クローン"
      ],
      "Delete rule '%s'?": [
        "ルール '%s' を削除しますか?"
      ],
      "Invalid user type of %s was provided": [
        "無効なユーザータイプ %s が指定されました"
      ],
      "Discovered hosts summary": [
        "検出されたホストの概要"
      ],
      "can't contain white spaces.": [
        "空白を含めることができません。"
      ],
      "must start with a letter or ERB.": [
        "文字または ERB で開始する必要があります。"
      ],
      "must be present.": [
        "必須です。"
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "ホストグループの組織 %s も検出ルールに関連付ける必要があります"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "ホストグループのロケーション %s も検出ルールに関連付ける必要があります"
      ],
      "Fact + prefix": [
        "ファクト + プレフィックス"
      ],
      "Random name": [
        "無作為の名前"
      ],
      "MAC-based name": [
        "MAC ベースの名前"
      ],
      "Invalid facts, must be a Hash": [
        "無効なファクトです。ハッシュである必要があります。"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "必要な discovery_fact '%s' がありません。プライマリーインターフェースの検出やホスト名の設定ができません"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "無効なファクト: discovery_hostname 設定の全ファクトで、ハッシュの値は無効です: %s"
      ],
      "Facts could not be imported": [
        "ファクトをインポートできませんでした"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "プロキシー %{url} からファクトを取得できませんでした: %{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "%{name} の (%{url}) で再起動を実行できません: %{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "%{ips} で %{action} を実行できません"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "%{name} の (%{url}) で kexec を実行できません: %{msg}"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "無効なホスト名: ホスト名を正規化できませんでした"
      ],
      "Reloading kernel on %s": [
        "カーネルを %s にリロード中"
      ],
      "Rebooting %s": [
        "%s を再起動中"
      ],
      "Kexec template not associated with operating system": [
        "オペレーティングシステムに関連付けられていない Kexec テンプレート"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "カーネル kexec URL は無効です: '%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "Init RAM kexec URL は無効です: '%s'"
      ],
      "Rebuild DNS for %s": [
        "%s の DNS の再構築"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "検出ファクト解析は、非検出ホスト '%{host}' では機能しません"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "検出ホスト '%{host}' では全 NIC がフィルタリングされています。フィルター: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "%{mac} が %{fact} で指定されたプライマリー NIC を見つけることができません。NIC フィルター: %{filter}"
      ],
      "Highlights": [
        "ハイライト"
      ],
      "Storage": [
        "ストレージ"
      ],
      "Hardware": [
        "ハードウェア"
      ],
      "Network": [
        "ネットワーク"
      ],
      "Software": [
        "ソフトウェア"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "その他"
      ],
      "IPAM must be configured for subnet '%s'": [
        "IPAM はサブネット '%s' 用に設定する必要があります"
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
        "イメージ API で返された HTTP/%{code}: '%{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "イメージ API 処理エラー: %{msg} (HTTP/%{code}、ボディー: %{body})"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "ホスト %s が検出されました。"
      ],
      "Discovered Host": [
        "検出されたホスト"
      ],
      "No discovered hosts available": [
        "検出されたホストがありません"
      ],
      "Host": [
        "ホスト"
      ],
      "Model": [
        "モデル"
      ],
      "CPUs": [
        "CPU"
      ],
      "Memory": [
        "メモリー"
      ],
      "Customize Host": [
        "ホストのカスタマイズ"
      ],
      "Create Host": [
        "ホストの作成"
      ],
      "Select all items in this page": [
        "このページのすべての項目を選択"
      ],
      "items selected. Uncheck to Clear": [
        "項目が選択されています。クリアするにはチェックを解除してください"
      ],
      "Name": [
        "名前"
      ],
      "IP Address": [
        "IP アドレス"
      ],
      "Disk Count": [
        "ディスク数"
      ],
      "Disks Size": [
        "ディスクサイズ"
      ],
      "Location": [
        "ロケーション"
      ],
      "Organization": [
        "組織"
      ],
      "Subnet": [
        "サブネット"
      ],
      "Last Facts Upload": [
        "最終ファクトのアップロード"
      ],
      "Actions": [
        "アクション"
      ],
      "Please Confirm": [
        "確認してください"
      ],
      "Cancel": [
        "取り消し"
      ],
      "Submit": [
        "送信"
      ],
      "Provision %s": [
        "%s のプロビジョニング"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "ホスト、ファクト、およびレポートもすべて破棄されるため、時間がかかる場合があります。"
      ],
      "Select location": [
        "ロケーションの選択"
      ],
      "Select organization": [
        "組織の選択"
      ],
      "Discovered host: %s": [
        "検出されたホスト: %s"
      ],
      "Interfaces": [
        "インターフェース"
      ],
      "Type": [
        "タイプ"
      ],
      "Identifier": [
        "ID"
      ],
      "MAC address": [
        "MAC アドレス"
      ],
      "IP address": [
        "IP アドレス"
      ],
      "Collapse All": [
        "すべて折りたたむ"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Foreman の検出されたホストの概要レポート"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b> 検出されたホストの概要"
      ],
      "Summary from %{time} ago to %{now}": [
        "%{time} 前から %{now} までの概要"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Foreman サーバーの検出されたホスト: %{foreman_url}"
      ],
      "Disk count": [
        "ディスク数"
      ],
      "Disks size": [
        "ディスクサイズ"
      ],
      "No discovered hosts for the selected period": [
        "選択された期間に検出されたホストはありません"
      ],
      "Foreman discovered hosts summary": [
        "Foreman の検出されたホストの概要"
      ],
      "No new discovered hosts for this period": [
        "この期間に検出された新規ホストはありません"
      ],
      "Primary": [
        "プライマリー"
      ],
      "Locations": [
        "ロケーション"
      ],
      "Organizations": [
        "組織"
      ],
      "Target host group for this rule with all properties set": [
        "このルールのターゲットホストグループ。すべてのプロパティーを設定しておいてください。"
      ],
      "Hostname for provisioned hosts": [
        "プロビジョニングされたホストのホスト名"
      ],
      "Hosts Limit": [
        "ホスト制限"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "このルールでプロビジョニングする最大ホスト数 (0 = 無制限)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "ルールの優先順位 (整数値が低いほど、優先順位が高い)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "プロビジョニングテンプレート (ERB) と同じ構文のターゲットホスト名テンプレートのパターンを指定します。"
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "ドメインは自動的に追加されます。空白のままの場合には、MAC アドレスに基づくホスト名が使用されます。"
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "@host 属性のほかに、ランダムな整数の rand 関数を利用できます。例:"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "ホスト名パターンの作成時に、生成されるホスト名が一意であることを確認します。"
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "ホスト名は数字で開始することができません。facter で提供される固有の情報 (MAC アドレス、BIOS またはシリアル ID) を使用することが適切な方法です。"
      ],
      "Clone %s": [
        "%s のクローン作成"
      ],
      "Edit %s": [
        "%s の編集"
      ],
      "Discovery Rules": [
        "検出ルール"
      ],
      "Create Rule": [
        "ルールの作成"
      ],
      "DiscoveryRule|Name": [
        "名前"
      ],
      "DiscoveryRule|Priority": [
        "優先順位"
      ],
      "DiscoveryRule|Query": [
        "クエリー"
      ],
      "Host Group": [
        "ホストグループ"
      ],
      "Hosts/Limit": [
        "ホスト/制限"
      ],
      "DiscoveryRule|Enabled": [
        "有効化"
      ],
      "New Discovery Rule": [
        "新規の検出ルール"
      ],
      "Discovered Rules": [
        "検出されたルール"
      ],
      "A summary of discovered hosts": [
        "検出されたホストの概要"
      ],
      "New hosts": [
        "新規ホスト"
      ],
      "One or more hosts have been discovered": [
        "1 つ以上のホストが検出されました"
      ],
      "Details": [
        "詳細"
      ],
      "Hosts": [
        "ホスト"
      ],
      "Error message goes here": [
        "エラーメッセージはこちらに表示されます"
      ],
      "Discovery": [
        "検出"
      ],
      "Discovery location": [
        "検出ロケーション"
      ],
      "The default location to place discovered hosts in": [
        "検出されたホストを配置するデフォルトのロケーション"
      ],
      "Discovery organization": [
        "検出組織"
      ],
      "The default organization to place discovered hosts in": [
        "検出されたホストを配置するデフォルトの組織"
      ],
      "Interface fact": [
        "インターフェースファクト"
      ],
      "Fact name to use for primary interface detection": [
        "プライマリーインターフェースの検出に使用するファクト名"
      ],
      "Create bond interfaces": [
        "ボンドインターフェースの作成"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "自動ボンドインターフェース (LLDP で同じ VLAN 上に別のインターフェースが検出された場合)"
      ],
      "Clean all facts": [
        "すべてのファクトのクリーニング"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "プロビジョニング時に報告されたすべてのファクトをクリーニング (検出ファクトを除く)"
      ],
      "Hostname facts": [
        "ホスト名ファクト"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "自動プロビジョニング"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "プロビジョニングルールに基づく新たに検出されたホストの自動プロビジョニング"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "プロビジョニング時の検出されたホストの自動的な再起動または kexec の実行"
      ],
      "Hostname prefix": [
        "ホスト名のプレフィックス"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "ホスト名に使用するデフォルトのプレフィックスは文字で開始する必要があります"
      ],
      "Fact columns": [
        "Fact 列"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "ハイライトされたファクト"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "ハイライトセクションのファクトを整理するための Regex (例: ^(abc|cde)$)"
      ],
      "Storage facts": [
        "ストレージファクト"
      ],
      "Regex to organize facts for storage section": [
        "ストレージセクションのファクトを整理するための Regex"
      ],
      "Software facts": [
        "ソフトウェアファクト"
      ],
      "Regex to organize facts for software section": [
        "ソフトウェアセクションのファクトを整理するための Regex"
      ],
      "Hardware facts": [
        "ハードウェアファクト"
      ],
      "Regex to organize facts for hardware section": [
        "ハードウェアセクションのファクトを整理するための Regex"
      ],
      "Network facts": [
        "ネットワークファクト"
      ],
      "Regex to organize facts for network section": [
        "ネットワークセクションのファクトを整理するための Regex"
      ],
      "IPMI facts": [
        "IPMI ファクト"
      ],
      "Regex to organize facts for ipmi section": [
        "ipmi セクションのファクトを整理するための Regex"
      ],
      "Lock PXE": [
        "PXE のロック"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "新規に検出されたホストを検出に固定するための PXE 設定の自動生成"
      ],
      "Locked PXELinux template name": [
        "ロックされた PXELinux テンプレート名"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "ホストを検出に固定する際に使用される PXELinux テンプレート"
      ],
      "Locked PXEGrub template name": [
        "ロックされた PXEGrub テンプレート名"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "ホストを検出に固定する際に使用される PXEGrub テンプレート"
      ],
      "Locked PXEGrub2 template name": [
        "ロックされた PXEGrub2 テンプレート名"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "ホストを検出に固定する際に使用される PXEGrub2 テンプレート"
      ],
      "Force DNS": [
        "DNS の強制的な実行"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "検出されたホストのプロビジョニング時の DNS エントリーの作成を強制的に実行"
      ],
      "Error on existing NIC": [
        "既存の NIC でのエラー"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "プロビジョニング NIC の MAC と一致する既存の管理ホストの検出を許可しない (エラーは早い段階で出されます)"
      ],
      "Type of name generator": [
        "名前ジェネレーターのタイプ"
      ],
      "Discovery hostname naming pattern": [
        "検出ホスト名の名前パターン"
      ],
      "Prefer IPv6": [
        "IPv6 を優先します"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "検出されたノードを呼び出す際に、IPv4 よりも IPv6 を優先します。"
      ],
      "Discovery Proxy": [
        "検出プロキシー"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "検出されたホストへの接続を管理するためにこのサブネット内で使用する検出プロキシー"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "検出されたホストへの接続を管理するためにこのサブネット内で使用する検出プロキシーの ID"
      ],
      "For more information please see ": [
        "詳細は、以下を参照してください: "
      ],
      "documentation": [
        "ドキュメント"
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        "このコンテキストで検出されたホストはありません。このページでは、プロビジョニングする予定の検出されたベアメタルまたは仮想ノードを表示しています。"
      ],
      "Foreman Discovery": [
        ""
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        "このコンテキストで検出された検出ルールはありません。検出されたホストで自動プロビジョニングを実行するための検出ルールを作成してください。"
      ],
      "Remote action:": [
        "リモートアクション:"
      ],
      "Import Puppet classes": [
        "Puppet クラスのインポート"
      ],
      "Import facts": [
        "ファクトのインポート"
      ],
      "Action with sub plans": [
        "サブプランによるアクション"
      ]
    }
  }
};