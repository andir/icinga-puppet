# icinga #

This is the icinga module. It provides basic (yet very heavy work-in-progress) code to monitor nodes using icinga.

Goals are to implement some sort of auto expiring of all exported resources..
Define a check where you need to: In your other puppet class just define a new icinga service without worrying about duplicates or collisions...


# How I imagine it to be used #

	class my_icinga_settings {
	
		class { 'icinga::params':
			resource_expire_time => 3600 * 24 *30 # 30 Days
		}
	
	}
	
	node 'my-icinga-server' {
		
		include my_icinga_settings
	
		icinga::server { $fqdn:
			icinga_web => true,
		}
	}
	
	node 'my-server1' {
	
		include my_icinga_settings
	
		icinga::check_tcp {
		 'check_http_80':	port => 80;
		 'check_ssh_22': port => 22;
		}
		icinga::check_icmp {
		 'check_icmp_localhost': ;
		 'check_icmp_google.com': host => 'google.com';
		}
		
		##
		## Implicit but if you want you can do it:
		##
		# icinga::host { $fqdn: contact_groups => ['noc', 'devs'], hostgroup => 'test-servers' }
	}



