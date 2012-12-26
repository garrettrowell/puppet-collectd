
class collectd::configure (
	$collectd_confdir = $collectd::params::collectd_confdir,
	$collectd_conf = $collectd::params::collectd_conf,
	$collection_conf = $collectd::params::collection_conf,
	$filters_conf = $collectd::params::filters_conf,
	$thresholds_conf = $collectd::params::thresholds_conf,
	$password_file = $collectd::params::password_file,
	$plugins = $collectd::params::plugins,
	$listen_address = "",
	$listen_port = "",
	$forward_address = "",
	$forward_port = "",
	$network_username = "",
	$network_password = "",
	$mysql_user = $collectd::params::mysql_user,
	$mysql_password = $collectd::params::mysql_password
) inherits collectd::params {

	file { $collectd_confdir : 
		ensure => directory
	}

        #Put collectd.conf in /etc/ on RHEL, normal confdir on others
        if $::osfamily == 'RedHat' {
          file { "/etc/${collectd_conf}" :
            ensure => file,
            content => template('collectd/collectd.conf.erb'),
          }
        } else {
          file { "${collectd_confdir}/${collectd_conf}" :
            ensure => file,
            content => template('collectd/collectd.conf.erb'),
          }
        }

	file { "${collectd_confdir}/${collection_conf}" :
		ensure => file,
		content => template('collectd/collection.conf.erb'),
	}

	file { "${collectd_confdir}/${filters_conf}" :
		ensure => file,
		content => template('collectd/filters.conf.erb'),
	}

	file { "${collectd_confdir}/${thresholds_conf}" :
		ensure => file,
		content => template('collectd/thresholds.conf.erb'),
	}

	if ($listen_address) {
		file { "${collectd_confdir}/${password_file}" :
			ensure => file,
			content => "$network_username:$network_password\n",
		}
	}


	Class['collectd::install'] -> Class['collectd::configure']

}
