#!/usr/bin/env ruby

require 'fileutils'
require 'net/http'
require 'net/https'
require 'uri'

def discover_server
  server = (discover_by_pxe or discover_by_dns)
  unless server =~ /^http/
    server = "http://#{server}"
  end
  server
end

def discover_by_pxe
  begin
    contents = File.open("/proc/cmdline", 'r') { |f| f.read }
    server_ip = contents.split.map { |x| $1 if x.match(/foreman.ip=(.*)/)}.compact
    if server_ip.size == 1
      return server_ip.join
    else
      return false
    end
  rescue
    return false
  end
end

def discover_by_dns
  begin
    contents = File.open("/proc/cmdline", 'r') { |f| f.read }
    server_name = contents.split.map { |x| $1 if x.match(/foreman.server=(.*)/)}.compact
    server_name = server_name.size == 1 ? server_name.join : 'razor'

    require 'socket'
    return TCPSocket.gethostbyname(server_name)[3..-1].first || false
  rescue
    return false
  end
end

begin
  uri = URI.parse(discover_server+'/discovery_init.sh')
  http = Net::HTTP.new(uri.host, uri.port)
  if uri.scheme == 'https' then
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
  response = http.request(Net::HTTP::Get.new(uri.request_uri))
  if response.code == "200"
    open("/opt/discovery_init.sh", "wb") do |file|
      file.write(response.body)
    end
    `chmod 755 /opt/discovery_init.sh`
  end
rescue Exception => e
  puts e.message
  puts e.backtrace
end
