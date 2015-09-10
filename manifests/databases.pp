# == define: pgbouncer::databases
#
# defined type that can be used to create the databases section in the config
# file
#
define pgbouncer::databases(
  $databases = [],
) {

  validate_array($databases)

  unless empty($databases[0]) {
    $uniq_name = "${databases[0]['dest_db']}_${databases[0]['auth_user']}"
    concat::fragment { $uniq_name:
      target  => $::pgbouncer::conffile,
      content => template('pgbouncer/pgbouncer.ini.databases.part2.erb'),
      order   => '02',
    }
  }
}
