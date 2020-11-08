#
# $Id$
#

module Msf
class Plugin::Stats < Msf::Plugin
  class ConsoleCommandDispatcher

    include Msf::Ui::Console::CommandDispatcher

    def name
      "Stats"
    end

    def commands
      {
        "top_ports" => "Print top X ports by count (default top 10)",
        "count_all" => "Print the number of hosts and services in the workspace",
        "count_hosts" => "Print the number of hosts in the workspace",
        "count_services" => "Print the number of services in the workspace",
      }
    end

    # Print top X ports by count (default top 10)
    def cmd_top_ports(num = 10)
      print_line("Top #{num} open ports:")
      print_line("Rank  | Port  | Count | Exploit?")
      print_line("--------------------------------")

      # Generate port list in descending order of frequency
      services = self.framework.db.workspace.services.where(state: "open")
      top = Hash.new(0)
      services.each do |service|
        top[service.port] += 1
      end
      top = top.sort_by {|k,v| v}.reverse

      # Display table of results
      i = 1
      top.each do |port,count|
        has_exploit = Msf::Modules::Metadata::Cache.instance.find(
          {"port"=>[[port.to_s], []]}
        ).count > 0 ? "Yes" : "No"
        #next if has_exploit == "No"
        print_line("\##{i}".ljust(5, " ") + " | "  + "#{port}".ljust(5, " ") + " | " + "#{count}".ljust(5, " ") + " | " + has_exploit)
        break if i == num.to_i
        i += 1
      end
    end # cmd_top_ports

    def cmd_count_all
      cmd_count_hosts()
      cmd_count_services()
    end

    def cmd_count_hosts
      hosts_all = self.framework.db.workspace.hosts
      hosts_alive = self.framework.db.workspace.hosts.where(state: "alive")
      print_line("#{hosts_all.length} total hosts (#{hosts_alive.length} alive)")
    end

    def cmd_count_services
      services_all = self.framework.db.workspace.services
      services_open = self.framework.db.workspace.services.where(state: "open")
      print_line("#{services_all.length} total services (#{services_open.length} open)")
    end
  end # Class ConsoleCommandDispatcher

  def initialize(framework, opts)
    super
    add_console_dispatcher(ConsoleCommandDispatcher)
  end

  def cleanup
    remove_console_dispatcher('Stats')
  end

  def name
    "stats"
  end

  def desc
    "Provides commands for gathering various statistics about the current workspace."
  end

protected
end

end
