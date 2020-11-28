# Metasploit-Plugins

A collection of Metasploit plugins I have written for various reasons.

## Overview

### stats.rb

This plugin simply provides a few commands for displaying stats about the current workspace such as most popular ports, total hosts/services, etc.

```
msf6 > load stats
[*] Successfully loaded plugin: stats
msf6 > count_all
8 total hosts (8 alive)
43 total services (32 open)
msf6 > count_hosts
8 total hosts (8 alive)
msf6 > count_services
43 total services (32 open)
msf6 > top_ports
Top 10 open ports:
Rank  | Port  | Count | Module?
--------------------------------
#1    | 80    | 8     | Yes
#2    | 443   | 5     | Yes
#3    | 22    | 3     | Yes
#4    | 53    | 2     | Yes
#5    | 25    | 2     | Yes
#6    | 21    | 2     | Yes
#7    | 7326  | 1     | No
#8    | 7000  | 1     | Yes
#9    | 5978  | 1     | No
#10   | 2022  | 1     | Yes
msf6 > top_ports 5
Top 5 open ports:
Rank  | Port  | Count | Module?
--------------------------------
#1    | 80    | 8     | Yes
#2    | 443   | 5     | Yes
#3    | 22    | 3     | Yes
#4    | 53    | 2     | Yes
#5    | 25    | 2     | Yes
msf6 >
```
