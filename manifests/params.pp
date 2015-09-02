# == Class: pgbouncer::params
#
# Private class included by pgbouncer to set parameters
#
class pgbouncer::params {
  
  $userlist                   = []
  $databases                  = []
  $dbtmpfile                  = '/tmp/pgbouncer-dbtmpfile'
  $paramtmpfile               = '/tmp/pgbouncer-paramtmpfile'
  $config_params              = undef
 
  # === Set OS specific variables (can be overridden by setting config_params) === #
  case $::osfamily {
    'RedHat', 'Linux': {
      $logfile                 = '/var/log/pgbouncer/pgbouncer.log'
      $pidfile                 = '/var/run/pgbouncer/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "$confdir/pgbouncer.ini"
      $userlist_file           = "$confdir/userlist.txt"
      $unix_socket_dir         = '/tmp'
      $pgbouncer_package_name  = pick($pgbouncer_package_name,'pgbouncer')
    }

    'Debian': {
      $logfile                 = '/var/log/postgresql/pgbouncer.log'
      $pidfile                 = '/var/run/postgresql/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "$confdir/pgbouncer.ini"
      $userlist_file           = "$confdir/userlist.txt"
      $unix_socket_dir         = '/var/run/postgresql'
      $pgbouncer_package_name  = pick($pgbouncer_package_name,'pgbouncer')
      $deb_default_file        = '/etc/default/pgbouncer'
    }

  } 

  # === Setup default parameters === #
  $default_config_params      = {
    logfile                     => $logfile,
    pidfile                     => $pidfile,
    unix_socket_dir             => $unix_socket_dir,
    auth_file                   => $userlist_file,
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

}
