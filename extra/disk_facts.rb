disk_types = ["xvd","vd","sd","hd"]
total_size = 0
total_disks = 0

disk_types.each do |type|
  Dir.open("/sys/block").entries.grep(/^#{type}/).each do |d|
    size = %x{/bin/cat /sys/block/#{d}/size}.chomp
    total_size += size.to_i
    total_disks += 1
    Facter.add("disk_size_#{d}".to_sym) do
      setcode do
        size
      end
    end
  end
end

Facter.add(:disk_total_size) do
  setcode do
    total_size
  end
end

Facter.add(:disk_total_number) do
  setcode do
    total_disks
  end
end

#! /usr/bin/env ruby
%x{fdisk -l 2>/dev/null}.split("\n").each do |l|
  puts $1 if l.match(/^Disk \/dev\/(?:(?:(?:sd|hd|x?vd)[a-z])|mmcblk[0-9]+).*?(\d+) bytes/)
end
