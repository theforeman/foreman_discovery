 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['pt_BR'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Valeria S Silva <valeriassilva@live.com>, 2015",
        "Language-Team": "Portuguese (Brazil) (http://www.transifex.com/foreman/foreman/language/pt_BR/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "pt_BR",
        "Plural-Forms": "nplurals=3; plural=(n == 0 || n == 1) ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;",
        "lang": "pt_BR",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=3; plural=(n == 0 || n == 1) ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;"
      },
      "List all discovered hosts": [
        "Listar todos os hosts descobertos"
      ],
      "filter results": [
        "filtrar resultados"
      ],
      "sort results": [
        "ordenar resultados"
      ],
      "paginate results": [
        "paginar resultados"
      ],
      "number of entries per request": [
        "número de entradas por requisições"
      ],
      "Show a discovered host": [
        "Exibir um host descoberto"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "Opção do nome de arquivo DHCP (Grub2 ou PXELinux por padrão)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Crie um host descoberto para testes (use /facts para criar novos hosts)"
      ],
      "Provision a discovered host": [
        "Provisionar um host descoberto"
      ],
      "required if host is managed and value is not inherited from host group": [
        "necessário se o host é gerenciado e valor não é herdado do grupo de host"
      ],
      "not required if using a subnet with DHCP proxy": [
        "não necessário se utilizar um subrede com proxy DHCP"
      ],
      "not required if it's a virtual machine": [
        "não é obrigatório se for uma máquina virtual"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "solicitado se o provisionamento não for baseado em imagem, o host for gerenciado e o valor não for herdado do grupo de host"
      ],
      "required if host is managed and custom partition has not been defined": [
        "requerido se o host é gerenciado e uma partição customizada não foi definida"
      ],
      "Host's owner type": [
        "Tipo de proprietário do host"
      ],
      "Host's parameters (array or indexed hash)": [
        "Parâmetros do host (matriz ou hash indexado)"
      ],
      "Name of the parameter": [
        "Nome do parâmetro"
      ],
      "Parameter value": [
        "Valor do parâmetro"
      ],
      "Type of value": [
        "Tipo de valor"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID a rastrear o status de tarefas de orquestração, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "obrigatório se o valor não for herdado do grupo de hosts ou da senha padrão nas configurações"
      ],
      "Delete a discovered host": [
        "Excluir um host descoberto"
      ],
      "Upload facts for a host, creating the host if required": [
        "Enviar fatos para um host, criando o host se necessário"
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "fatos com hashes pra o host com conjunto mínimo de fatos: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (exemplo caso a interface primária tenha como nome eth0)"
      ],
      "Execute rules against a discovered host": [
        "Executar regras em relação a um host descoberto"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "Hospedeiro %{host} foi provisionado com regra %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "Incapaz de fornecer %{host}: %{errors}"
      ],
      "No rule found for host %s": [
        "Nenhuma regra encontrada para o host %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Executar regras em relação a todos os hosts descobertos atualmente"
      ],
      "Errors during auto provisioning: %s": [
        "Erros durante o provisionamento automático: %s"
      ],
      "No discovered hosts to provision": [
        "Nenhum host descoberto para provisionamento"
      ],
      "%s discovered hosts were provisioned": [
        "%s hosts descobertos foram provisionados"
      ],
      "Refreshing the facts of a discovered host": [
        "Atualizando os fatos de um host descoberto"
      ],
      "Rebooting a discovered host": [
        "Reinicializando um host descoberto"
      ],
      "Rebooting all discovered hosts": [
        "Reinicializando todos os hosts descobertos"
      ],
      "Discovered hosts are rebooting now": [
        "Hosts descobertos estão reinicializando agora"
      ],
      "List all discovery rules": [
        "Listar todas as regras do Discovery"
      ],
      "Show a discovery rule": [
        "Exibir uma regra do Discovery"
      ],
      "represents rule name shown to the users": [
        "representa nome da regra exibido para os usuários"
      ],
      "query to match discovered hosts for the particular rule": [
        "consulta para corresponder hosts descobertos a uma regra específica"
      ],
      "the hostgroup that is used to auto provision a host": [
        "o grupo de hosts que é usado para provisionar um host automático"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "define um padrão para atribuir nomes de hosts legíveis aos hosts correspondentes"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "habilita para limitar a quantidade máxima de hosts provisionados por regra"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "coloca as regras em ordem, números menores primeiro. Deve ser maior que zero"
      ],
      "flag is used for temporary shutdown of rules": [
        "sinalizador é usado para desligamento temporário de regras"
      ],
      "location ID for provisioned hosts": [
        "ID de local para hosts provisionados"
      ],
      "organization ID for provisioned hosts": [
        "ID de organização para hosts provisionados"
      ],
      "Create a discovery rule": [
        "Criar uma regra do Discovery"
      ],
      "Update a rule": [
        "Atualizar uma regra"
      ],
      "Delete a rule": [
        "Excluir uma regra"
      ],
      "List all fact values of a given discovered host": [
        "Lista todos os valores de fatos de um host descoberto específico"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "Não foi possível encontrar uma regra do Discovery, nenhum host foi fornecido (verifique as permissões)"
      ],
      "No hostgroup associated with rule '%s'": [
        "Nenhum grupo de hosts associado à regra '%s'"
      ],
      "Errors during reboot: %s": [
        "Erros durante a reinicialização: %s"
      ],
      "No discovered hosts to reboot": [
        "Nenhum host descoberto para reinicialização"
      ],
      "Successfully provisioned %s": [
        "%s provisionado com êxito"
      ],
      "Facts refreshed for %s": [
        "Fatos atualizados para %s"
      ],
      "Failed to refresh facts for %s": [
        "Falha ao atualizar fatos para %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "Falha em atualizar os fatos para %{hostname} com erro % %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "Tipo de host %s não pode ser reinicializado"
      ],
      "Rebooting host %s": [
        "Reinicializando hosts"
      ],
      "Failed to reboot host %s": [
        "Falha ao reinicializar host %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Falha na reinicialização do host{hostname} com erro % %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "Falha ao reinicializar hosts com erro %s"
      ],
      "Destroyed selected hosts": [
        "Hosts selecionados foram destruídos"
      ],
      "The following hosts were not deleted: %s": [
        "Os hosts a seguir não foram removidos: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Falha ao provisionar host automaticamente %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Hosts descobertos estão sendo provisionados agora"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "Descoberto anfitrião relatado de sub-rede desconhecida, a comunicação não será procurada."
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "Os hospedeiros descobertos relatados de sub-rede desconhecida são %s, a comunicação não será procurada."
      ],
      "No hosts were found with that id or name": [
        "Nenhum host foi encontrado com o id ou nome"
      ],
      "No hosts selected": [
        "Não foi selecionado nenhum host"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Ocorreu um erro ao selecionar hosts - %s"
      ],
      "Rule enabled": [
        "Regra habiitada"
      ],
      "Rule disabled": [
        "Regra desabilitada"
      ],
      "Auto Provision": [
        "Provisionamento automático"
      ],
      "Refresh facts": [
        "Atualizar fatos"
      ],
      "Reboot": [
        "Reiniciar"
      ],
      "Back": [
        "Retornar"
      ],
      "Select Action": [
        "Selecionar Ação"
      ],
      "Delete %s?": [
        "Excluir"
      ],
      "Assign Organization": [
        "Atribuir Organização"
      ],
      "Assign Location": [
        "Atribuir Local"
      ],
      "Delete": [
        "Excluir"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - Os hosts a seguir devem ser modificados em breve"
      ],
      "N/A": [
        "N/D"
      ],
      "New in the last 24 hours": [
        "Novo nas últimas 24 horas"
      ],
      "Not reported in more than 7 days": [
        "Não relatado em mais de sete dias"
      ],
      "Reported in the last 7 days": [
        "Relatado nos últimos sete dias"
      ],
      "Provision": [
        "Provisão"
      ],
      "Discovered Hosts": [
        "Hosts descobertos"
      ],
      "Associated Hosts": [
        "Hosts associados"
      ],
      "Disable": [
        "Desabilitar"
      ],
      "Disable rule '%s'?": [
        "Desabilitar regra '%s'?"
      ],
      "Enable": [
        "Habilitar"
      ],
      "Enable rule '%s'?": [
        "Habilitar regra '%s'?"
      ],
      "Clone": [
        "Clonar"
      ],
      "Delete rule '%s'?": [
        "Excluir regra '%s'?"
      ],
      "Invalid user type of %s was provided": [
        "O tipo de usuário inválido %s foi fornecido"
      ],
      "Discovered hosts summary": [
        "Resumo de hosts descobertos"
      ],
      "can't contain white spaces.": [
        "não pode conter espaços em branco."
      ],
      "must start with a letter or ERB.": [
        "deve iniciar com uma letra ou ERB."
      ],
      "must be present.": [
        "deve estar presente."
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "A organização do grupo de hosts %s deve também estar associada à regra do Discovery",
        "As organizações do grupo de hosts %s também devem estar associadas à regra do Discovery",
        "As organizações do grupo de hosts %s também devem estar associadas à regra do Discovery"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "O local do grupo de hosts %s deve também estar associado à regra do Discovery",
        "Os locais do grupo de hosts %s também devem estar associados à regra do Discovery",
        "Os locais do grupo de hosts %s também devem estar associados à regra do Discovery"
      ],
      "Fact + prefix": [
        "Fato + prefixo"
      ],
      "Random name": [
        "Nome aleatório"
      ],
      "MAC-based name": [
        "Nome baseado em MAC"
      ],
      "Invalid facts, must be a Hash": [
        "Fatos inválidos, deve ser um hash"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "'%s' discovery_fact  esperado está ausente, não é possível detectar a interface primária e definir o nome do host"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "Fatos inválidos: o hash não contém um valor válido para nenhum dos fatos na configuração discovery_hostname: %s"
      ],
      "Facts could not be imported": [
        "Fatos não podem ser importados"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "Não foi possível obter fatos por procuração %{url}: %{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "Incapaz de reiniciar em %{name} (%{url}): %{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "Incapaz de realizar %{action} em %{ips}"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "Incapaz de executar o kexec em %{name} (%{url}): %{msg}"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "Nome de host inválido: não foi possível normalizar o nome do host"
      ],
      "Reloading kernel on %s": [
        "Recarregando kernel no %s"
      ],
      "Rebooting %s": [
        "Reinicializando %s"
      ],
      "Kexec template not associated with operating system": [
        "Modelo kexec não associado ao sistema operacional"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "URL do kexec do kernel é inválido: '%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "URL do kexec do RAM inicial é inválido: '%s'"
      ],
      "Rebuild DNS for %s": [
        "Recompilar DNS para %s"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "O analisador de fatos de descoberta não funciona com o host '%{host}' de não descoberta"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "Discovered host '%{host}' tem todos os DNIs filtrados, filtro: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "Não foi possível encontrar DNI primário com %{mac} especificado via '%{fact}', filtro DNI: %{filter}"
      ],
      "Highlights": [
        "Destaques"
      ],
      "Storage": [
        "Armazenamento"
      ],
      "Hardware": [
        "Hardware"
      ],
      "Network": [
        "Rede"
      ],
      "Software": [
        "Software"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "Diversos"
      ],
      "IPAM must be configured for subnet '%s'": [
        "O IPAM deve ser configurado para a sub-rede '%s'"
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
        "Imagem API retornada HTTP/%{code} com '%{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "Erro de processamento da API de imagem: %{msg} (HTTP/%{code}, corpo: %{body})"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "Anfitrião %s foi ditado"
      ],
      "Discovered Host": [
        "Host descoberto",
        "Hosts descobertos",
        "Hosts descobertos"
      ],
      "No discovered hosts available": [
        "Nenhum host descoberto disponível"
      ],
      "Host": [
        "Máquina"
      ],
      "Model": [
        "Modelar"
      ],
      "CPUs": [
        "CPUs"
      ],
      "Memory": [
        "Memória"
      ],
      "Customize Host": [
        "Personalizar host"
      ],
      "Create Host": [
        "Criar host"
      ],
      "Select all items in this page": [
        "Selecionar todos os itens desta página"
      ],
      "items selected. Uncheck to Clear": [
        "itens selecionados. Desselecione para Limpar"
      ],
      "Name": [
        "Nome"
      ],
      "IP Address": [
        "Endereço IP"
      ],
      "Disk Count": [
        "Contagem de discos"
      ],
      "Disks Size": [
        "Tamanho dos discos"
      ],
      "Location": [
        "Local"
      ],
      "Organization": [
        "Organização"
      ],
      "Subnet": [
        "Suberede"
      ],
      "Last Facts Upload": [
        "Carregamento dos últimos fatos"
      ],
      "Actions": [
        "Ações"
      ],
      "Please Confirm": [
        "Por favor confirme"
      ],
      "Cancel": [
        "Cancelar"
      ],
      "Submit": [
        "Enviar"
      ],
      "Provision %s": [
        "Provisão"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "Isto pode demorar um pouco, pois todos os hosts, fatos e relatórios também serão destruídos"
      ],
      "Select location": [
        "Selecionar local"
      ],
      "Select organization": [
        "Selecionar organização"
      ],
      "Discovered host: %s": [
        "Host descoberto"
      ],
      "Interfaces": [
        "Interfaces"
      ],
      "Type": [
        "Tipo"
      ],
      "Identifier": [
        "Identificador"
      ],
      "MAC address": [
        "Endereço MAC"
      ],
      "IP address": [
        "Endereco de IP"
      ],
      "Collapse All": [
        "Recolher todos"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Relatório de resumo dos hosts descobertos pelo Foreman"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "Resumo de hosts descobertos pelo Foreman"
      ],
      "Summary from %{time} ago to %{now}": [
        "Resumo de {time} atrás até agora"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Descoberto hosts do servidor Foreman em %{foreman_url}"
      ],
      "Disk count": [
        "Contagem de Disco"
      ],
      "Disks size": [
        "Tamanho do disco"
      ],
      "No discovered hosts for the selected period": [
        "Nenhum host descoberto para o período selecionado"
      ],
      "Foreman discovered hosts summary": [
        "Resumo de hosts descobertos pelo Foreman"
      ],
      "No new discovered hosts for this period": [
        "Nenhum novo host descoberto para esse período"
      ],
      "Primary": [
        "Primário"
      ],
      "Locations": [
        "Locais"
      ],
      "Organizations": [
        "Organizações"
      ],
      "Target host group for this rule with all properties set": [
        "Grupo de host de destino para essa regra com todas as propriedades definidas"
      ],
      "Hostname for provisioned hosts": [
        "Nome do host para hosts provisionados"
      ],
      "Hosts Limit": [
        "Limite de Hosts"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Máximo de hosts provisionados com essa regra (0 = ilimitado)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Prioridades de regras (inteiro menor significa prioridade mais alta)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Especificar padrão do modelo do nome de host de destino na mesma sintaxe dos modelos de provisionamento (ERB)."
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "O domínio será anexado automaticamente. Um nome de host baseado no endereço MAC será usado quando deixado em branco."
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "Além do atributo @host, a função rand para inteiros aleatórios está disponível. Exemplos:"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "Ao criar padrões de nome de host, garanta que os nomes de host resultantes sejam exclusivos"
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "Os nomes de host não devem iniciar com números. Uma boa abordagem é usar informações exclusivas fornecidas pelo Facter (endereço MAC, BIOS ou ID de série)."
      ],
      "Clone %s": [
        "clone"
      ],
      "Edit %s": [
        "Editar"
      ],
      "Discovery Rules": [
        "Regras do Discovery"
      ],
      "Create Rule": [
        "Criar regra"
      ],
      "DiscoveryRule|Name": [
        "DiscoveryRule|Nome"
      ],
      "DiscoveryRule|Priority": [
        "DiscoveryRule|Prioridade"
      ],
      "DiscoveryRule|Query": [
        "DiscoveryRule|Consulta"
      ],
      "Host Group": [
        "Grupo de Host"
      ],
      "Hosts/Limit": [
        "Hosts/Limite"
      ],
      "DiscoveryRule|Enabled": [
        "DiscoveryRule|Habilitado"
      ],
      "New Discovery Rule": [
        "Nova regra do Discovery"
      ],
      "Discovered Rules": [
        "Regras Descobertas"
      ],
      "A summary of discovered hosts": [
        "Um resumo de hosts descobertos"
      ],
      "New hosts": [
        "Novos hosts"
      ],
      "One or more hosts have been discovered": [
        "Um ou mais hosts foram descobertos"
      ],
      "Details": [
        "Detalhes"
      ],
      "Hosts": [
        "Hosts"
      ],
      "Error message goes here": [
        "A mensagem de erro vai aqui"
      ],
      "Discovery": [
        "Descoberta"
      ],
      "Discovery location": [
        "Local do Discovery"
      ],
      "The default location to place discovered hosts in": [
        "O local padrão onde colocar hosts descobertos"
      ],
      "Discovery organization": [
        "Organização do Discovery"
      ],
      "The default organization to place discovered hosts in": [
        "A organização padrão onde colocar os hosts descobertos"
      ],
      "Interface fact": [
        "Fato da interface"
      ],
      "Fact name to use for primary interface detection": [
        "Nome do fato a ser usado para detecção de interface primária"
      ],
      "Create bond interfaces": [
        "Criar interfaces de vínculo"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "Interface de vínculo automático (se outra interface for detectada na mesma VLAN via LLDP)"
      ],
      "Clean all facts": [
        "Limpar todos fatos"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "Limpar todos os fatos relatados durante o provisionamento (exceto fatos do Discovery)"
      ],
      "Hostname facts": [
        "Fatos do nome do host"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "Provisionamento automático"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "Provisionar automaticamente novos hosts descobertos de acordo com as regras de provisionamento"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "Automaticamente reinicializar o host descoberto durante o provisionamento ou executar kexec nele"
      ],
      "Hostname prefix": [
        "Prefixo do nome do host"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "Prefixo padrão a ser usado para o nome do host, deve iniciar com uma letra"
      ],
      "Fact columns": [
        "Colunas de fatos"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "Fatos destacados"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "Regex para organizar fatos para seção de destaques - por exemplo ^(abc|cde)$"
      ],
      "Storage facts": [
        "Fatos de armazenamento"
      ],
      "Regex to organize facts for storage section": [
        "Regex para organizar fatos da seção de armazenamento"
      ],
      "Software facts": [
        "Fatos de software"
      ],
      "Regex to organize facts for software section": [
        "Regex para organizar fatos da seção de software"
      ],
      "Hardware facts": [
        "Fatos de hardware"
      ],
      "Regex to organize facts for hardware section": [
        "Regex para organizar fatos da seção de hardware"
      ],
      "Network facts": [
        "Fatos de rede"
      ],
      "Regex to organize facts for network section": [
        "Regex para organizar fatos da seção de rede"
      ],
      "IPMI facts": [
        "Fatos IPMI"
      ],
      "Regex to organize facts for ipmi section": [
        "Regex para organizar fatos da seção IPMI"
      ],
      "Lock PXE": [
        "Bloquear PXE"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "Gerar configuração PXE automaticamente para fixar um host novo descoberto para o Discovery"
      ],
      "Locked PXELinux template name": [
        "Nome do modelo PXELinux bloqueado"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "Modelo PXELinux a ser usado para fixar um host no Discovery"
      ],
      "Locked PXEGrub template name": [
        "Nome do modelo PXEGrub bloqueado"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "Modelo PXEGrub a ser usado para fixar um host no Discovery"
      ],
      "Locked PXEGrub2 template name": [
        "Nome do modelo PXEGrub2 bloqueado"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "Modelo PXEGrub2 a ser usado para fixar um host no Discovery"
      ],
      "Force DNS": [
        "Forçar DNS"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "Forçar criação de entradas DNS ao provisionar host descoberto"
      ],
      "Error on existing NIC": [
        "Erro na NIC existente"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "Não permitir descobrir MAC correspondente de host gerenciado existente de uma NIC de provisionamento (apresenta erros cedo)"
      ],
      "Type of name generator": [
        "Tipo de gerador de nomes"
      ],
      "Discovery hostname naming pattern": [
        "Padrão de nomenclatura de nome de host de descoberta"
      ],
      "Prefer IPv6": [
        "Prefira IPv6"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "Prefere IPv6 a IPv4 ao chamar os nós descobertos"
      ],
      "Discovery Proxy": [
        "Proxy do Discovery"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "Proxy do Discovery a ser usado nesta sub-rede para gerenciar conexão com hosts descobertos"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "ID do proxy do Discovery a ser usado nesta sub-rede para gerenciar conexões com hosts descobertos"
      ],
      "For more information please see ": [
        "Para mais informações, consulte "
      ],
      "documentation": [
        "documentação"
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        "Nenhum anfitrião descoberto foi encontrado neste contexto. Esta página mostra os nós descobertos de metal nu ou virtuais esperando para serem provisionados."
      ],
      "Foreman Discovery": [
        ""
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        "Não foram encontradas Regras de Descoberta neste contexto. Criar Regras de Descoberta para realizar provisionamento automatizado em Hosts Descobertos"
      ],
      "Remote action:": [
        "Ação remota:"
      ],
      "Import Puppet classes": [
        "Importar classes de Puppet"
      ],
      "Import facts": [
        "Importar fatos"
      ],
      "Action with sub plans": [
        "Ação com subplanos "
      ]
    }
  }
};