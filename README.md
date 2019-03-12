# Metasploit-Plugins

A collection of Metasploit plugins I have written for various reasons.

## Overview

### stats.rb

This plugin simply provides a few commands for displaying stats about the current workspace such as most popular ports, total hosts/services, etc.

```
msf5 > load stats
[*] Successfully loaded plugin: stats
msf5 > count_all
9 total hosts (9 alive)
61 total services (55 open)
msf5 > count_hosts
9 total hosts (9 alive)
msf5 > count_services
61 total services (55 open)
msf5 > top_ports
Top 10 open ports:
Rank  | Port  | Count
---------------------
#1    | 445   | 5
#2    | 139   | 4
#3    | 135   | 4
#4    | 49157 | 3
#5    | 49155 | 3
#6    | 49154 | 3
#7    | 80    | 3
#8    | 49156 | 2
#9    | 49153 | 2
#10   | 49152 | 2
msf5 > top_ports 5
Top 5 open ports:
Rank  | Port  | Count
---------------------
#1    | 445   | 5
#2    | 139   | 4
#3    | 135   | 4
#4    | 49157 | 3
#5    | 49155 | 3
```
