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
Port  | Count
-------------
445   | 5
139   | 4
135   | 4
49157 | 3
49155 | 3
49154 | 3
80    | 3
49156 | 2
49153 | 2
49152 | 2
msf5 > top_ports 5
Top 5 open ports:
Port  | Count
-------------
445   | 5
139   | 4
135   | 4
49157 | 3
49155 | 3
```
