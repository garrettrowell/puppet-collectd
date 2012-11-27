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
	$plguins = [syslog, cpu, df, disk, entropy, interface, load, memory, process, swap, uptime, users, vmem],
) {

	#
	# Packages
	#

	$packages = $operatingsystem ? {
		debian => ['collectd-core', 'libgcrypt11', 'libcurl3-gnutls'],
		ubuntu => ['collectd-core', 'libgcrypt11', 'libcurl3-gnutls'],
		freebsd => ['collectd', 'libgcrypt'],
	}

	#
	# Configuration file locations
	#

	$collectd_conf = "/etc/collectd/collectd.conf"

	$collection_conf = "/etc/collectd/collection.conf"

	$filters_conf = "/etc/collectd/filters.conf"

	$thresholds_conf = "/etc/collectd/thresholds.conf"

	$password_file = "/etc/collectd/passwd"

}
