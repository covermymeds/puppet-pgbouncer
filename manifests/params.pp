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

  # === Set OS specific variables === #
  case $::osfamily {
    'RedHat', 'Linux': {
      $logfile                 = '/var/log/pgbouncer/pgbouncer.log'
      $pidfile                 = '/var/run/pgbouncer/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "${confdir}/pgbouncer.ini"
      $userlist_file           = "${confdir}/userlist.txt"
      $unix_socket_dir         = '/tmp'
    }
    'Debian': {
      $logfile                 = '/var/log/postgresql/pgbouncer.log'
      $pidfile                 = '/var/run/postgresql/pgbouncer.pid'
      $confdir                 = '/etc/pgbouncer'
      $conffile                = "${confdir}/pgbouncer.ini"
      $userlist_file           = "${confdir}/userlist.txt"
      $unix_socket_dir         = '/var/run/postgresql'
      $deb_default_file        = '/etc/default/pgbouncer'
    }
    'FreeBSD': {
      $logfile                 = '/var/log/pgbouncer/pgbouncer.log'
      $pidfile                 = '/var/run/pgbouncer/pgbouncer.pid'
      $confdir                 = '/usr/local/etc'
      $conffile                = "${confdir}/pgbouncer.ini"
      $userlist_file           = "${confdir}/pgbouncer.users"
      $unix_socket_dir         = '/tmp'
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
    client_tls_sslmode          => 'disable',
    client_tls_key_file         => '/etc/pgbouncer/client.key',
    client_tls_cert_file        => '/etc/pgbouncer/client.crt',
    client_tls_ca_file          => '/etc/pgbouncer/rootca.crt',
    server_tls_sslmode          => 'disable',
    server_tls_key_file         => '/etc/pgbouncer/server_ssl.key',
    server_tls_cert_file        => '/etc/pgbouncer/server_ssl.crt',
    server_tls_protocols        => 'all',
  }
}
