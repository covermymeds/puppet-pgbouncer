# == Class: pgbouncer
#
# Installs the pbouncer package and configures the ini.
#
# === Examples
#
#  class { pgbouncer: }
#
# === Hiera example
#
# Hieradata gets merged overtop of defaults. All valid config options excepted
#
#  pgbouncer::params::config_params:
#    listen_port: 7432
#    max_client_conn: 100
#
# === Authors
#
# CJ Estel
#
# === Credits
#
# This module is loosely based on https://bitbucket.org/landcareresearch/puppet-pgbouncer
#
# === Copyright
#
# CoverMyMeds
#
# === License
#
# MIT License (MIT)
#
class pgbouncer ( ) inherits pgbouncer::params {
 
  anchor{'pgbouncer::begin':}

  # Same package name for both redhat based and debian based
  package{ $_pgbouncer_package_name:
    ensure  => installed,
    require => [ Class['postgresql::repo::yum_postgresql_org'], Anchor['pgbouncer::begin'] ],
  }

  # verify we have a file managed by concat
  concat { "$conffile":
    ensure => present,
  }
 
  #build the pgbouncer parameter piece of the config file
  concat::fragment { "$paramtmpfile":
    target  => "$conffile",
    content => template('pgbouncer/pgbouncer.ini.param.part.erb'),
    order   => '02',
    require => Package[$_pgbouncer_package_name],
  }

  # check if debian
  if $::osfamily == 'Debian' {
    file{ "$_deb_default_file":
      ensure  => file,
      source  => 'puppet:///modules/pgbouncer/pgbouncer',
      require => Package[$_pgbouncer_package_name],
      before  => File["$auth_file"],
    }
  }
 
  # check if we have an authlist (default is undefined)
  if $auth_list {
    validate_array($auth_list)

    file {"$auth_file":
      ensure  => file,
      content => template('pgbouncer/userlist.txt.erb'),
    }
  }

  # check if we have a database list (default is undefined)
  if $databases {
    validate_array($databases)

    #build the databases piece of the config file
    concat::fragment { "$dbtmpfile":
      target  => "$conffile",
      content => template('pgbouncer/pgbouncer.ini.databases.part.erb'),
      order   => '01',
    }
  }

  service {'pgbouncer':
    ensure    => running,
    subscribe => File["$auth_file", "$conffile"],
  }
  
  anchor{'pgbouncer::end':
    require => Service['pgbouncer'],
  }
}
