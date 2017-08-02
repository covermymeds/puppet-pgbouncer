# == Class: pgbouncer::params
#
# Private class included by pgbouncer to set parameters
#
class pgbouncer::params {

  $userlist                   = []
  $databases                  = []
  $paramtmpfile               = '/tmp/pgbouncer-paramtmpfile'
  $config_params              = undef
  $pgbouncer_package_name     = 'pgbouncer'
  $service_start_with_system  = true
  $user                       = 'pgbouncer'
  $group                      = 'pgbouncer'
  $require_repo               = true
  $userlist_from_mkauth       = false
  $postgres_user              = 'postgres'

  # === Set OS specific variables === #
  case $::osfamily {
    'RedHat', 'Linux': {
      $logfile                 = '/var/log/pgbouncer/pgbouncer.log'
      $pidfile                 = '/var/run/pgbouncer/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "${confdir}/pgbouncer.ini"
      $userlist_file           = "${confdir}/userlist.txt"
      $unix_socket_dir         = '/tmp'
      $deb_default_file        = undef
      $mkauth                  = '/etc/pgbouncer/mkauth.py'
    }
    'Debian': {
      $logfile                 = '/var/log/postgresql/pgbouncer.log'
      $pidfile                 = '/var/run/postgresql/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "${confdir}/pgbouncer.ini"
      $userlist_file           = "${confdir}/userlist.txt"
      $unix_socket_dir         = '/var/run/postgresql'
      $deb_default_file        = '/etc/default/pgbouncer'
      $mkauth                  = '/usr/share/pgbouncer/mkauth.py'
    }
    'FreeBSD': {
      $logfile                 = '/var/log/pgbouncer/pgbouncer.log'
      $pidfile                 = '/var/run/pgbouncer/pgbouncer.pid'
      $confdir                 = '/usr/local/etc'
      $conffile                = "${confdir}/pgbouncer.ini"
      $userlist_file           = "${confdir}/pgbouncer.users"
      $unix_socket_dir         = '/tmp'
      $deb_default_file        = undef
      $mkauth                  = '/usr/local/etc/pgbouncer/mkauth.py'
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
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
    pool_mode                   => 'session',
    server_reset_query          => 'DISCARD ALL',
    server_check_query          => 'select 1',
    server_check_delay          => '30',
    max_client_conn             => '1000',
    default_pool_size           => '20',
    online_reload               => false,
  }
}
