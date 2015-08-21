# == Class: pgbouncer::params
#
# Private class included by pgbouncer to set parameters
#
# === Parameters
#
# auth_list is undefined by default.  You can create an array in hieradata like the 
# example below or you can call the resource directly from a third party module
# pgbouncer::params::auth_list:
#   - '"user" "password"'
#   - '"user2" "password2"'
#
# databases is undefined by default.  You can create an array in hieradata like the
# example below or you can call the resource direclty from a third party module
# pgbouncer::params::databases:
#   - 'postgres = host=localhost    dbname=postgres'
#   - 'admin    = host=localhost    dbname=admin'
#
# pgbouncer_package_name is the name of the package that should be installed. By
# default, this should be picked by the OS, but you can specify a name here if you'd like
#
# Config params can be passed in via hieradata by creating a hash for the below hash key
# A hiera_hash merge is done so that settings can be overridden
# pgbouncer::params::config_params:
#
# Link to pgbouncer doc: http://pgbouncer.projects.pgfoundry.org/doc/config.html
#
class pgbouncer::params(
  $auth_list                  = undef,
  $databases                  = undef,
  $pgbouncer_package_name     = undef,
  $dbtmpfile                  = '/tmp/pgbouncer-dbtmpfile',
  $paramtmpfile               = '/tmp/pgbouncer-paramtmpfile',
){
 
  # === Do a hiera_merge to pull together all pieces of hieradata === #
  $hiera_params = hiera_hash('pgbouncer::params::config_params', {})

  # === Set OS specific variables (can be overridden by setting config_params) === #
  case $::osfamily {
    'RedHat', 'Linux': {
      $logfile                 = '/var/log/pgbouncer.log'
      $pidfile                 = '/var/run/pgbouncer/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "$confdir/pgbouncer.ini"
      $auth_file               = "$confdir/userlist.txt"
      $unix_socket_dir         = '/tmp'
      $_pgbouncer_package_name  = pick($pgbouncer_package_name,'pgbouncer')
    }

    'Debian': {
      $logfile                 = '/var/log/postgresql/pgbouncer.log'
      $pidfile                 = '/var/run/postgresql/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "$confdir/pgbouncer.ini"
      $auth_file               = "$confdir/userlist.txt"
      $unix_socket_dir         = '/var/run/postgresql'
      $_pgbouncer_package_name  = pick($pgbouncer_package_name,'pgbouncer')
      $deb_default_file        = '/etc/default/pgbouncer'
    }

  } 

  # === Setup default parameters === #
  $default_config_params      = {
    logfile                     => $logfile,
    pidfile                     => $pidfile,
    unix_socket_dir             => $unix_socket_dir,
    auth_file                   => $auth_file,
    listen_addr                 => '*',
    listen_port                 => '6432',
    admin_users                 => 'postgres',
    stats_users                 => 'postgres',
    auth_type                   => 'trust',
    pool_mode                   => 'transaction',
    server_reset_query          => 'DISCARD ALL',
    server_check_query          => 'select 1',
    server_check_delay          => '30',
    max_client_conn             => '1000',
    default_pool_size           => '20',
  }

  # === merge the defaults and the info pulled from hiera to feed the template === #
  $load_config_params = merge($default_config_params, $hiera_params)

}
