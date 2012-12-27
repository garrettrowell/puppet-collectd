# Class: collectd::params
#
# Determine default values for collectd parameters
#
# Parameters:
#   [*port*]           - network port for client/server mode.
#   [*mysql_user*]     - username for mysql plugin.
#   [*mysql_password*] - password for mysql plugin.
#
class collectd::params (
	$port = 25826,
	$mysql_user = 'collectd',
	$mysql_password = '',
	$plugins = [syslog, cpu, df, disk, entropy, interface, load, memory, process, swap, uptime, users, vmem],
) {

	#
	# Packages
	#

	$packages = $::osfamily ? {
		redhat => ['collectd', 'libgcrypt'],
		debian => ['collectd-core', 'libgcrypt11', 'libcurl3-gnutls'],
		freebsd => ['collectd', 'libgcrypt'],
	}

	#
	# Configuration file locations
	#

        case $::osfamily {
          'RedHat': { $collectd_confdir = "/etc/collectd.d" } 
           default: { $collectd_confdir = "/etc/collectd"   }
        }

	$collectd_conf = "collectd.conf"

	$collection_conf = "collection.conf"

	$filters_conf = "filters.conf"

	$thresholds_conf = "thresholds.conf"

	$password_file = "passwd"

}
