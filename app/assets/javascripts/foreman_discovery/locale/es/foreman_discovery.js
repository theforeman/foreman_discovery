 locales['foreman_discovery'] = locales['foreman_discovery'] || {}; locales['foreman_discovery']['es'] = {
  "domain": "foreman_discovery",
  "locale_data": {
    "foreman_discovery": {
      "": {
        "Project-Id-Version": "foreman_discovery v22.0.4",
        "Report-Msgid-Bugs-To": "",
        "PO-Revision-Date": "2013-11-15 17:25+0000",
        "Last-Translator": "Sergio Ocón-Cárdenas <sergio.ocon@redhat.com>, 2014",
        "Language-Team": "Spanish (http://www.transifex.com/foreman/foreman/language/es/)",
        "MIME-Version": "1.0",
        "Content-Type": "text/plain; charset=UTF-8",
        "Content-Transfer-Encoding": "8bit",
        "Language": "es",
        "Plural-Forms": "nplurals=3; plural=n == 1 ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;",
        "lang": "es",
        "domain": "foreman_discovery",
        "plural_forms": "nplurals=3; plural=n == 1 ? 0 : n != 0 && n % 1000000 == 0 ? 1 : 2;"
      },
      "List all discovered hosts": [
        "Confeccionar una lista de los hosts detectados"
      ],
      "filter results": [
        "filtrar resultados"
      ],
      "sort results": [
        "organizar resultados"
      ],
      "paginate results": [
        "paginar resultados"
      ],
      "number of entries per request": [
        "número de entradas por solicitud"
      ],
      "Show a discovered host": [
        "Mostrar un host detectado"
      ],
      "DHCP filename option (Grub2 or PXELinux by default)": [
        "Opción de nombre de archivo DHCP (Grub2 o PXELinux en forma predeterminada)"
      ],
      "Create a discovered host for testing (use /facts to create new hosts)": [
        "Crear un host detectado para utilizar en pruebas (utilizar/hechos para crear nuevos hosts)"
      ],
      "Provision a discovered host": [
        "Aprovisionar un host detectado"
      ],
      "required if host is managed and value is not inherited from host group": [
        "obligatorio si los hosts están administrados y el valor no se ha heredado de un grupo de hosts"
      ],
      "not required if using a subnet with DHCP proxy": [
        "no es necesario si se usa una subred con un proxy DHCP"
      ],
      "not required if it's a virtual machine": [
        "no es necesario si no se trata de una máquina virtual"
      ],
      "required if not imaged based provisioning and host is managed and value is not inherited from host group": [
        "obligatorio si el aprovisionamiento no se basa en imágenes,  el host está administrado  y el valor no se hereda de un grupo de hosts"
      ],
      "required if host is managed and custom partition has not been defined": [
        "obligatorio si el host está administrado y no se han definido particiones personalizadas"
      ],
      "Host's owner type": [
        "Tipo de propietario de host"
      ],
      "Host's parameters (array or indexed hash)": [
        "Parámetros del host (array o hash indexado)"
      ],
      "Name of the parameter": [
        "Nombre del parámetro"
      ],
      "Parameter value": [
        "Valor del parámetro"
      ],
      "Type of value": [
        "Tipo de valor"
      ],
      "UUID to track orchestration tasks status, GET /api/orchestration/:UUID/tasks": [
        "UUID para seguir el estado de la tarea de orquestación, GET /api/orchestration/:UUID/tasks"
      ],
      "required if value is not inherited from host group or default password in settings": [
        "es necesario si el valor no se hereda del grupo del host o de la contraseña predeterminada en las configuraciones"
      ],
      "Delete a discovered host": [
        "Eliminar un host detectado"
      ],
      "Upload facts for a host, creating the host if required": [
        "Subir eventos para un host, si es necesario cree el host."
      ],
      "hash containing facts for the host with minimum set of facts: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (example in case primary interface is named eth0)": [
        "hash que contiene eventos correspondientes al host con un conjunto mínimo de eventos: discovery_bootif, macaddress_eth0, ipaddress, ipaddress_eth0, interfaces: eth0 (ejemplo en caso de que la interfaz principal se denomine eth0)"
      ],
      "Execute rules against a discovered host": [
        "Ejecutar reglas en función de un host detectado"
      ],
      "Host %{host} was provisioned with rule %{rule}": [
        "Host %{host} se aprovisionó con la regla %{rule}"
      ],
      "Unable to provision %{host}: %{errors}": [
        "No se puede provisionar %{host}: %{errors}"
      ],
      "No rule found for host %s": [
        "No se ha encontrado ninguna regla para el anfitrión %s"
      ],
      "Execute rules against all currently discovered hosts": [
        "Ejecutar reglas contra todos los hosts detectados actualmente"
      ],
      "Errors during auto provisioning: %s": [
        "Errores durante el aprovisionamiento automático: %s"
      ],
      "No discovered hosts to provision": [
        "No hay hosts detectados para aprovisionar"
      ],
      "%s discovered hosts were provisioned": [
        "%s los hosts descubiertos fueron aprovisionados"
      ],
      "Refreshing the facts of a discovered host": [
        "Actualizando los eventos de un host detectado"
      ],
      "Rebooting a discovered host": [
        "Reiniciando un host detectado"
      ],
      "Rebooting all discovered hosts": [
        "Reiniciando todos los hosts detectados"
      ],
      "Discovered hosts are rebooting now": [
        "Se están reiniciando ahora los hosts detectados"
      ],
      "List all discovery rules": [
        "Mostrar todas las reglas de detección"
      ],
      "Show a discovery rule": [
        "Mostrar una regla de detección"
      ],
      "represents rule name shown to the users": [
        "representa el nombre de la regla que se les muestra a los usuarios"
      ],
      "query to match discovered hosts for the particular rule": [
        "consulta para establecer una coincidencia de los hosts detectados respecto de dicha regla específica"
      ],
      "the hostgroup that is used to auto provision a host": [
        "grupo de host utilizado para autoaprovisionar un host"
      ],
      "defines a pattern to assign human-readable hostnames to the matching hosts": [
        "define un patrón para asignarles a los hosts coincidentes nombres de hosts aptos para la lectura humana"
      ],
      "enables to limit maximum amount of provisioned hosts per rule": [
        "se habilita para limitar la cantidad máxima de hosts aprovisionados por regla"
      ],
      "puts the rules in order, low numbers go first. Must be greater then zero": [
        "pone las reglas en orden, los números más bajos van en primer lugar. Deben ser superiores a cero"
      ],
      "flag is used for temporary shutdown of rules": [
        "se utiliza una bandera para el cierre temporario de las reglas"
      ],
      "location ID for provisioned hosts": [
        "ID de ubicación para hosts aprovisionados"
      ],
      "organization ID for provisioned hosts": [
        "ID de organización para los hosts aprovisionados"
      ],
      "Create a discovery rule": [
        "Crear una regla de detección"
      ],
      "Update a rule": [
        "Actualizar una regla"
      ],
      "Delete a rule": [
        "Eliminar una regla"
      ],
      "List all fact values of a given discovered host": [
        "Mostrar todos los valores de eventos de un host detectado específico"
      ],
      "Unable to find a discovery rule, no host provided (check permissions)": [
        "No es posible buscar una regla de detección, no se ha aprovisionado un host (verificar permisos)"
      ],
      "No hostgroup associated with rule '%s'": [
        "No hay ningún grupo de hosts asociado a la regla '%s'"
      ],
      "Errors during reboot: %s": [
        "Errores durante el reinicio: %s"
      ],
      "No discovered hosts to reboot": [
        "No se detectaron hosts para reiniciar"
      ],
      "Successfully provisioned %s": [
        "Aprovisionado con éxito %s"
      ],
      "Facts refreshed for %s": [
        "Datos actualizados para %s"
      ],
      "Failed to refresh facts for %s": [
        "Fallo en la actualización de los hechos para %s"
      ],
      "Failed to refresh facts for %{hostname} with error %{error_message}": [
        "Fallo en la actualización de los datos para %{hostname} con error %{error_message}"
      ],
      "Host of type %s can not be rebooted": [
        "El host de tipo %s no puede ser reiniciado"
      ],
      "Rebooting host %s": [
        "Reiniciar el host %s"
      ],
      "Failed to reboot host %s": [
        "Fallo en el reinicio del host %s"
      ],
      "Failed to reboot host %{hostname} with error %{error_message}": [
        "Fallo al reiniciar el host %{hostname} con error %{error_message}"
      ],
      "Failed to reboot hosts with error %s": [
        "Fallo al reiniciar los hosts con error %s"
      ],
      "Destroyed selected hosts": [
        "Eliminados equipos seleccionados"
      ],
      "The following hosts were not deleted: %s": [
        "Los siguientes hosts no fueron eliminados: %s"
      ],
      "Failed to auto provision host %s: %s": [
        "Fallo en el aprovisionamiento automático del host %s: %s"
      ],
      "Discovered hosts are provisioning now": [
        "Los hosts detectados se están aprovisionando ahora"
      ],
      "Discovered host reported from unknown subnet, communication will not be proxied.": [
        "El host descubierto se reporta desde una subred desconocida, la comunicación no será proxy."
      ],
      "Discovered hosts reported from unknown subnet are %s, communication will not be proxied.": [
        "Los hosts descubiertos reportados desde una subred desconocida son %s, la comunicación no será proxy."
      ],
      "No hosts were found with that id or name": [
        "No se han encontrado equipos con ese id o nombre"
      ],
      "No hosts selected": [
        "Ningún host seleccionado"
      ],
      "Something went wrong while selecting hosts - %s": [
        "Algo ha fallado al seleccionar hosts - %s"
      ],
      "Rule enabled": [
        "Regla habilitada"
      ],
      "Rule disabled": [
        "Regla deshabilitada"
      ],
      "Auto Provision": [
        "Autoaprovisionamiento"
      ],
      "Refresh facts": [
        "Refrescar datos"
      ],
      "Reboot": [
        "Reiniciar"
      ],
      "Back": [
        "Atrás"
      ],
      "Select Action": [
        "Seleccionar una acción"
      ],
      "Delete %s?": [
        "Borrar %s?"
      ],
      "Assign Organization": [
        "Asignar Organización"
      ],
      "Assign Location": [
        "Asignar Lugar"
      ],
      "Delete": [
        "Borrar"
      ],
      "%s - The following hosts are about to be changed": [
        "%s - Los siguientes hosts están a punto de ser cambiados"
      ],
      "N/A": [
        "N/C"
      ],
      "New in the last 24 hours": [
        "Nuevo en las últimas 24 horas"
      ],
      "Not reported in more than 7 days": [
        "No se informó en más de 7 días"
      ],
      "Reported in the last 7 days": [
        "Informado en los últimos 7 días"
      ],
      "Provision": [
        "Aprovisionar"
      ],
      "Discovered Hosts": [
        "Hosts detectados"
      ],
      "Associated Hosts": [
        "Hosts asociados"
      ],
      "Disable": [
        "Deshabilitar"
      ],
      "Disable rule '%s'?": [
        "¿Desactivar la regla '%s'?"
      ],
      "Enable": [
        "Habilitar"
      ],
      "Enable rule '%s'?": [
        "¿Habilitar la regla '%s'?"
      ],
      "Clone": [
        "Clonar"
      ],
      "Delete rule '%s'?": [
        "¿Borrar la regla '%s'?"
      ],
      "Invalid user type of %s was provided": [
        "Se proporcionó un tipo de usuario no válido de %s "
      ],
      "Discovered hosts summary": [
        "Resumen de hosts detectados"
      ],
      "can't contain white spaces.": [
        "no puede incluir espacios en blanco."
      ],
      "must start with a letter or ERB.": [
        "debe comenzar con una letra o ERB."
      ],
      "must be present.": [
        "debe estar presente."
      ],
      "Host group organization %s must also be associated to the discovery rule": [
        "La organización del grupo de host %s debe estar asociada también con la regla de detección",
        "Las organizaciones del grupo de host %s deben estar asociadas también con la regla de detección",
        "Las organizaciones del grupo de host %s deben estar asociadas también con la regla de detección"
      ],
      "Host group location %s must also be associated to the discovery rule": [
        "La ubicación del grupo de host %s debe estar asociada también con la regla de detección",
        "Las ubicaciones del grupo de host %s deben estar asociadas también con la regla de detección",
        "Las ubicaciones del grupo de host %s deben estar asociadas también con la regla de detección"
      ],
      "Fact + prefix": [
        "Hecho + prefijo"
      ],
      "Random name": [
        "Nombre aleatorio"
      ],
      "MAC-based name": [
        "Nombre basado en MAC"
      ],
      "Invalid facts, must be a Hash": [
        "Eventos inválidos. Debe ser un hash"
      ],
      "Expected discovery_fact '%s' is missing, unable to detect primary interface and set hostname": [
        "Falta el discovery_fact '%s', no se puede detectar la interfaz primaria y establecer el nombre de host"
      ],
      "Invalid facts: hash does not contain a valid value for any of the facts in the discovery_hostname setting: %s": [
        "Hechos no válidos: el hash no contiene un valor válido para ninguno de los hechos de la configuración discovery_hostname: %s"
      ],
      "Facts could not be imported": [
        "No se pudieron importar los eventos"
      ],
      "Could not get facts from proxy %{url}: %{error}": [
        "No se pudieron obtener datos del proxy %{url}: %{error}"
      ],
      "Unable to perform reboot on %{name} (%{url}): %{msg}": [
        "No se puede realizar el reinicio en %{name} (%{url}): %{msg}"
      ],
      "Unable to perform %{action} on %{ips}": [
        "No se puede realizar %{action} en %{ips}"
      ],
      "Unable to perform kexec on %{name} (%{url}): %{msg}": [
        "No se puede realizar kexec en %{name} (%{url}): %{msg}"
      ],
      "Invalid hostname: Could not normalize the hostname": [
        "Nombre de host inválido: no es posible normalizar el nombre de host"
      ],
      "Reloading kernel on %s": [
        "Recarga del núcleo en %s"
      ],
      "Rebooting %s": [
        "Reiniciando %s"
      ],
      "Kexec template not associated with operating system": [
        "Plantilla kexec no asociada con el sistema operativo"
      ],
      "Kernel kexec URL is invalid: '%s'": [
        "La URL del kernel kexec no es válida: '%s'"
      ],
      "Init RAM kexec URL is invalid: '%s'": [
        "Init RAM kexec URL no es válido: '%s'"
      ],
      "Rebuild DNS for %s": [
        "Reconstruir el DNS para %s"
      ],
      "Discovery fact parser does not work with non-discovery host '%{host}'": [
        "El analizador de hechos de descubrimiento no funciona con el host de no descubrimiento '%{host}'"
      ],
      "Discovered host '%{host}' has all NICs filtered out, filter: %{filter}": [
        "El host descubierto '%{host}' tiene todos los NICs filtrados, filtro: %{filter}"
      ],
      "Unable to find primary NIC with %{mac} specified via '%{fact}', NIC filter: %{filter}": [
        "No se puede encontrar el NIC primario con %{mac} especificado a través de '%{fact}', filtro NIC: %{filter}"
      ],
      "Highlights": [
        "Aspectos destacados"
      ],
      "Storage": [
        "Almacenamiento"
      ],
      "Hardware": [
        "Hardware"
      ],
      "Network": [
        "Red"
      ],
      "Software": [
        "Software"
      ],
      "IPMI": [
        "IPMI"
      ],
      "Miscellaneous": [
        "Misceláneo"
      ],
      "IPAM must be configured for subnet '%s'": [
        "IPAM debe estar configurado para la subred '%s'"
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
        "La API de imágenes devuelve HTTP/%{code} con '%'.{body}"
      ],
      "Image API processing error: %{msg} (HTTP/%{code}, body: %{body})": [
        "Error de procesamiento de la API de imágenes: %{msg} (HTTP/%{code}, body: %{body})"
      ],
      "One or more hosts with failed discovery due to error: %s": [
        ""
      ],
      "Host %s has been dicovered": [
        "El anfitrión %s ha sido descubierto"
      ],
      "Discovered Host": [
        "Host detectado",
        "Hosts detectados",
        "Hosts detectados"
      ],
      "No discovered hosts available": [
        "No hay hosts detectados disponibles"
      ],
      "Host": [
        "host"
      ],
      "Model": [
        "Modelado"
      ],
      "CPUs": [
        "CPU"
      ],
      "Memory": [
        "Memoria"
      ],
      "Customize Host": [
        "Personalizar host"
      ],
      "Create Host": [
        "Crear host"
      ],
      "Select all items in this page": [
        "Seleccionar todos los objetos de esta página"
      ],
      "items selected. Uncheck to Clear": [
        "objetos seleccionados. Desactivar para limpiar"
      ],
      "Name": [
        "Nombre"
      ],
      "IP Address": [
        "Dirección IP"
      ],
      "Disk Count": [
        "Conteo de discos"
      ],
      "Disks Size": [
        "Tamaño de los discos"
      ],
      "Location": [
        "Ubicación"
      ],
      "Organization": [
        "Organización"
      ],
      "Subnet": [
        "Subred"
      ],
      "Last Facts Upload": [
        "Última carga de datos"
      ],
      "Actions": [
        "Acciones"
      ],
      "Please Confirm": [
        "Confirmar"
      ],
      "Cancel": [
        "Cancelar"
      ],
      "Submit": [
        "Enviar"
      ],
      "Provision %s": [
        "Disposición %s"
      ],
      "This might take a while, as all hosts, facts and reports will be destroyed as well": [
        "Esta acción puede tardar un rato, ya que se eliminarán todos los equipos, datos e informes."
      ],
      "Select location": [
        "Seleccionar localización"
      ],
      "Select organization": [
        "Seleccionar organización"
      ],
      "Discovered host: %s": [
        "Descubierto el anfitrión: %s"
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
        "Dirección MAC"
      ],
      "IP address": [
        "Dirección IP"
      ],
      "Collapse All": [
        "Contraer todo"
      ],
      "Summary report for discovered hosts from Foreman": [
        "Informe de resumen de los hosts detectados de Foreman"
      ],
      "<b>Foreman</b> Discovered hosts summary": [
        "<b>Foreman</b> Resumen de los anfitriones descubiertos"
      ],
      "Summary from %{time} ago to %{now}": [
        "Resumen de %{time} hace a %{now}"
      ],
      "Discovered hosts from Foreman server at %{foreman_url}": [
        "Hosts descubiertos del servidor Foreman al %{foreman_url}"
      ],
      "Disk count": [
        "Número de discos"
      ],
      "Disks size": [
        "Tamaño de discos"
      ],
      "No discovered hosts for the selected period": [
        "No se detectaron hosts para el periodo seleccionado"
      ],
      "Foreman discovered hosts summary": [
        "Resumen de hosts detectados de Foreman"
      ],
      "No new discovered hosts for this period": [
        "No se detectaron nuevos hosts para este periodo"
      ],
      "Primary": [
        "Primario"
      ],
      "Locations": [
        "Ubicaciones"
      ],
      "Organizations": [
        "Organizaciones"
      ],
      "Target host group for this rule with all properties set": [
        "Grupo de host de destino para esta regla con el conjunto completo de propiedades"
      ],
      "Hostname for provisioned hosts": [
        "Nombre de host para los hosts aprovisionados"
      ],
      "Hosts Limit": [
        "Límite de hosts"
      ],
      "Maximum hosts provisioned with this rule (0 = unlimited)": [
        "Hosts máximos aprovisionados con esta regla (0 = ilimitado)"
      ],
      "Rule priority (lower integer means higher priority)": [
        "Prioridad de la regla (el número entero más bajo significa una mayor prioridad)"
      ],
      "Specify target hostname template pattern in the same syntax as in Provisioning Templates (ERB).": [
        "Especificar el patrón de la plantilla del nombre de host de destino con la misma sintaxis que en las Plantillas de aprovisionamiento (ERB)."
      ],
      "Domain will be appended automatically. A hostname based on MAC address will be used when left blank.": [
        "El dominio se agregará en forma automática. Se utilizará un nombre de host basado en la dirección MAC cuando quede en blanco."
      ],
      "In addition to @host attribute function rand for random integers is available. Examples:": [
        "Además del atributo @host, la función aleatoria para los números enteros aleatorizados se encuentra disponible. Ejemplos:"
      ],
      "When creating hostname patterns, make sure the resulting host names are unique.": [
        "Al crear patrones de nombres de host, asegúrese de que los nombres de host resultantes sean únicos."
      ],
      "Hostnames must not start with numbers. A good approach is to use unique information provided by facter (MAC address, BIOS or serial ID).": [
        "Los nombres de hosts no deben comenzar con números. Una buena estrategia consiste en utilizar la información particular aprovisionada por el suministrador de eventos (dirección MAC, BIOS o ID de serie)."
      ],
      "Clone %s": [
        "Clon %s"
      ],
      "Edit %s": [
        "Editar %s"
      ],
      "Discovery Rules": [
        "Reglas de detección"
      ],
      "Create Rule": [
        "Crear regla"
      ],
      "DiscoveryRule|Name": [
        "Regla de detección|Nombre"
      ],
      "DiscoveryRule|Priority": [
        "Regla de detección|Prioridad"
      ],
      "DiscoveryRule|Query": [
        "Regla de detección|Consulta"
      ],
      "Host Group": [
        "Grupo de Equipo"
      ],
      "Hosts/Limit": [
        "Hosts/Límite"
      ],
      "DiscoveryRule|Enabled": [
        "Regla de detección|Habilitada"
      ],
      "New Discovery Rule": [
        "Nueva regla de detección"
      ],
      "Discovered Rules": [
        "Reglas descubiertas"
      ],
      "A summary of discovered hosts": [
        "Resumen de los hosts detectados"
      ],
      "New hosts": [
        "Nuevos anfitriones"
      ],
      "One or more hosts have been discovered": [
        "Se detectaron uno o más hosts"
      ],
      "Details": [
        "Detalles"
      ],
      "Hosts": [
        "Hosts"
      ],
      "Error message goes here": [
        "El mensaje de error va aquí"
      ],
      "Discovery": [
        "Descubrimiento"
      ],
      "Discovery location": [
        "Ubicación de la detección"
      ],
      "The default location to place discovered hosts in": [
        "La ubicación predeterminada para colocar hosts descubiertos "
      ],
      "Discovery organization": [
        "Organización de detección"
      ],
      "The default organization to place discovered hosts in": [
        "La ubicación predeterminada para colocar organizaciones descubiertas "
      ],
      "Interface fact": [
        "Evento de interfaz"
      ],
      "Fact name to use for primary interface detection": [
        "Nombre de evento que debe utilizarse para la detección de la interfaz principal"
      ],
      "Create bond interfaces": [
        "Crear interfaces de asociación"
      ],
      "Automatic bond interface (if another interface is detected on the same VLAN via LLDP)": [
        "Interfaz de asociación aleatoria (si se detecta otra interfaz en la misma VLAN mediante LLDP)"
      ],
      "Clean all facts": [
        "Eliminar todos los eventos"
      ],
      "Clean all reported facts during provisioning (except discovery facts)": [
        "Eliminar todos los eventos informados durante el aprovisionamiento (excepto los eventos de detección)"
      ],
      "Hostname facts": [
        "Eventos del nombre de host"
      ],
      "List of facts to use for the hostname (first wins)": [
        ""
      ],
      "Auto provisioning": [
        "Autoaprovisionamiento"
      ],
      "Automatically provision newly discovered hosts, according to the provisioning rules": [
        "Aprovisionar automáticamente los hosts recientemente detectados, de acuerdo con las reglas de aprovisionamiento"
      ],
      "Automatically reboot or kexec discovered host during provisioning": [
        "Reiniciar en forma automática o host kexec detectado durante el aprovisionamiento"
      ],
      "Hostname prefix": [
        "Prefijo del nombre de host"
      ],
      "The default prefix to use for the host name, must start with a letter": [
        "Prefijo predeterminado que debe utilizarse para el nombre de host. Debe comenzar con una letra"
      ],
      "Fact columns": [
        "Columnas de eventos"
      ],
      "Extra facter columns to show in host lists": [
        ""
      ],
      "Highlighted facts": [
        "Eventos destacados"
      ],
      "Regex to organize facts for highlights section - e.g. ^(abc|cde)$": [
        "Regex para organizar los eventos para la sección de aspectos destacados, por ejemplo, ^(abc|cde)$"
      ],
      "Storage facts": [
        "Eventos de almacenamiento"
      ],
      "Regex to organize facts for storage section": [
        "Regex para organizar eventos para la sección de almacenamiento"
      ],
      "Software facts": [
        "Eventos de software"
      ],
      "Regex to organize facts for software section": [
        "Regex para organizar eventos para la sección de software"
      ],
      "Hardware facts": [
        "Eventos de hardware"
      ],
      "Regex to organize facts for hardware section": [
        "Regex para organizar eventos para sección de hardware"
      ],
      "Network facts": [
        "Eventos de red"
      ],
      "Regex to organize facts for network section": [
        "Regex para organizar los eventos para la sección de redes"
      ],
      "IPMI facts": [
        "Eventos IPMI"
      ],
      "Regex to organize facts for ipmi section": [
        "Regex para organizar eventos para la sección ipmi"
      ],
      "Lock PXE": [
        "Bloquear PXE"
      ],
      "Automatically generate PXE configuration to pin a newly discovered host to discovery": [
        "Generar configuración PXE en forma automática para adjuntar un host descubierto recientemente a la detección"
      ],
      "Locked PXELinux template name": [
        "Nombre de plantilla PXELinux bloqueada"
      ],
      "PXELinux template to be used when pinning a host to discovery": [
        "Debe utilizarse la plantilla PXELinux para adjuntar un host a la detección"
      ],
      "Locked PXEGrub template name": [
        "Nombre de plantilla PXEGrub bloqueado"
      ],
      "PXEGrub template to be used when pinning a host to discovery": [
        "Plantilla PXEGrub que debe utilizarse para adjuntar un host a la detección"
      ],
      "Locked PXEGrub2 template name": [
        "Nombre de plantilla PXEGrub2 bloqueado"
      ],
      "PXEGrub2 template to be used when pinning a host to discovery": [
        "Plantilla PXEGrub2 que debe utilizarse al adjuntar un host a la detección"
      ],
      "Force DNS": [
        "Forzar DNS"
      ],
      "Force DNS entries creation when provisioning discovered host": [
        "Forzar la creación de entradas DNS al aprovisionar host detectado"
      ],
      "Error on existing NIC": [
        "Error en la NIC existente"
      ],
      "Do not allow to discover existing managed host matching MAC of a provisioning NIC (errors out early)": [
        "No permitir detectar host administrados existentes que coincidan con la MAC de una NIC de aprovisionamiento (se produce un error temprano)"
      ],
      "Type of name generator": [
        "Tipo de generador de nombre"
      ],
      "Discovery hostname naming pattern": [
        "Detección de patrón de definición de nombre de host"
      ],
      "Prefer IPv6": [
        "Preferir IPv6"
      ],
      "Prefer IPv6 to IPv4 when calling discovered nodes": [
        "Preferir IPv6 a IPv4 al llamar a los nodos descubiertos"
      ],
      "Discovery Proxy": [
        "Proxy de detección"
      ],
      "Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "Proxy de detección para usar en esta subred para administrar la conexión con los hosts detectados"
      ],
      "ID of Discovery Proxy to use within this subnet for managing connection to discovered hosts": [
        "ID del proxy de detección para usar en esta subred para administrar la conexión con los hosts detectados"
      ],
      "For more information please see ": [
        "Para obtener más información, consulte "
      ],
      "documentation": [
        "documentación"
      ],
      "No discovered hosts found in this context. This page shows discovered bare-metal or virtual nodes waiting to be provisioned.": [
        "No se han encontrado hosts descubiertos en este contexto. Esta página muestra los nodos bare-metal o virtuales descubiertos en espera de ser aprovisionados."
      ],
      "Foreman Discovery": [
        ""
      ],
      "No Discovery Rules found in this context. Create Discovery Rules to perform automated provisioning on Discovered Hosts": [
        "No se han encontrado Reglas de Descubrimiento en este contexto. Crear Reglas de Descubrimiento para realizar un aprovisionamiento automatizado en los Hosts Descubiertos."
      ],
      "Remote action:": [
        "Acción remota:"
      ],
      "Import Puppet classes": [
        "Importar clases Puppet"
      ],
      "Import facts": [
        "Importar datos"
      ],
      "Action with sub plans": [
        "Acción con subplanes"
      ]
    }
  }
};