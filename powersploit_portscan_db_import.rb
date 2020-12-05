#
# $Id$
#

require 'nokogiri'

module Msf
class Plugin::PowerSploitPortscanDBImport < Msf::Plugin
  class ConsoleCommandDispatcher

    include Msf::Ui::Console::CommandDispatcher

    def name
      "PowerSploit Invoke-Portscan XML Import"
    end

    def commands
      {
        "powersploit_portscan_db_import" => "Import hosts and services from PowerSploit's Invoke-Portscan XML files",
      }
    end

    def cmd_powersploit_portscan_db_import_help
      print_line("Usage:   powersploit_portscan_db_import <filename.xml>")
      print_line("Example: powersploit_portscan_db_import 8.8.8.8.xml")
      print_line("Example: powersploit_portscan_db_import scans/*.xml")
    end

    def cmd_powersploit_portscan_db_import_tabs(str, words)
      tab_complete_filenames(str, words)
    end

    def cmd_powersploit_portscan_db_import(*args)
      # Check args
      if (args.length != 1)
        cmd_powersploit_portscan_db_import_help
	    return false
       end

      # Attempt to load file(s)
      files = ::Dir.glob(::File.expand_path(args[0].to_s))
      files.each do |file|
        begin 
          doc = Nokogiri::XML(File.read(file))
        rescue
          print_warning("File not found: #{file}")
          return false
        end

        print_status("Processing #{file}")

        # TODO - Basic filetype check to make sure it's from Invoke-Portscan

        data = {:workspace => framework.db.workspace}

        # Attempt to parse file
        hosts = doc.xpath('//Host[@Status="Up"]')
        # Swap these if you want all hosts, even the dead ones
        #hosts = doc.xpath('//Host') # Swap these if you want all hosts, even the dead ones
        hosts.each do |host|
          # Skip any "hosts" which are just the whole CIDR range
          next if host['id'].include? "/"
          data[:host] = host['id']
          data[:state] = host['Status'] == 'Up' ? Msf::HostState::Alive : Msf::HostState::Dead
          print_status("Importing #{host['id']}")
          framework.db.report_host(data)
          host.xpath('.//Port[@state="open"]').each do |port|
          # Swap these if you want all services, even the closed and filtered ones
          #host.xpath('.//Port').each do |port|
            data[:host] = host['id']
            data[:proto] = 'tcp'
            data[:port] = port['id']
            case port['state']
            when 'open'
              data[:state] = Msf::ServiceState::Open
            when 'closed'
              data[:state] = Msf::ServiceState::Closed
            when 'filtered'
              data[:state] = Msf::ServiceState::Filtered
            else
              data[:state] = Msf::ServiceState::Unknown
            end
            framework.db.report_service(data)
          end
        end
      end

    end # Function cmd_powersploit_portscan_db_import
  end # Class ConsoleCommandDispatcher

  def initialize(framework, opts)
    super
    add_console_dispatcher(ConsoleCommandDispatcher)
  end

  def cleanup
    remove_console_dispatcher('PowerSploit Portscan DB Import')
  end

  def name
    "PowerSploit Portscan DB Import"
  end

  def desc
    "Imports XML from PowerSploit's Invoke-Portscan script"
  end

protected
end # Class Plugin::PowerSploitPortscanDBImport < Msf::Plugin

end # Module
