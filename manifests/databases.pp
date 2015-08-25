define pgbouncer::databases( 
  $databases = [],
) {

  validate_array($databases)

  concat::fragment { "${databases[0]['dest_db']}_${databases[0]['auth_user']}":
    target  => '/etc/pgbouncer/pgbouncer.ini',
    content => template('pgbouncer/pgbouncer.ini.databases.part2.erb'),
    order   => '02',
  }
}
