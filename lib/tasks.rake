require 'open4'
require 'ftools'

desc <<-END_DESC
A task to (re)build the discovery TCL image using the latest code from
github for the smart proxy. Outputs to ./discovery_image/*

Available conditions:
* build_verbose - print all the STDOUT and STDERR of the buildscript
END_DESC
namespace :discovery do
  task :build_image => :environment do

    verbose = ENV['build_verbose'] && ENV['build_verbose'] != 'false' ? true : false

    # This requires a lot of root-level actions, lets ensure we have root access
    if Process.uid == 0 && Process.euid == 0
      prefix = ''
    else
      puts 'not running as root, testing sudo access'
      `sudo true`
      unless $?.success?
        puts "Please run this task with root/sudo priviledges"
        exit 1
      end
      puts 'sudo access confirmed'
      prefix = 'sudo'
    end

    # dep check
    unless system("which unsquashfs")
      puts "please install unsquashfs"
      exit 1
    end
    unless system("which advdef")
      puts "please install advdef"
      exit 1
    end

    script=`bundle show foreman_discovery`.strip + '/extra/build_iso.sh'
    builddir=''
    puts 'Building TCL Discovery Image - this may take a while'
    begin
      status = Open4::popen4("#{prefix} #{script}") do |pid, stdin, stdout, stderr|
        puts "pid        : #{ pid }" if verbose
        stdrout=stdout.read.strip
        builddir = stdrout.split("\n").delete_if {|x| x !~ /#TMPDIR#/}.to_s.split(' ').last
        puts "stdout     : #{ stdrout }" if verbose
        puts "stderr     : #{ stderr.read.strip }" if verbose
      end
    rescue Exception => e
      e.message
      e.backtrace
    end

    if status.exitstatus == 0
      Dir.mkdir 'discovery_image' unless File.directory?('discovery_image')
      File.copy "#{builddir}/initrd.gz", './discovery_image/'
      File.copy "#{builddir}/vmlinuz", './discovery_image/'
      puts "Your Discovery Image is in ./discovery_image - please copy these files"
      puts "to your TFTP server and configure the default boot to use them"
    else
      puts "status     : #{ status.inspect }"
      puts "exitstatus : #{ status.exitstatus }"
      puts "builddir   : #{ builddir.inspect }"
      puts 'Run with build_verbose=true for more detail' unless verbose
    end

  end
end
