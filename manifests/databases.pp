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
    concat::fragment {
    "${databases[0]['dest_db']}_${databases[0]['auth_user']}":
      target  => $::pgbouncer::conffile,
      content => template('pgbouncer/pgbouncer.ini.databases.part2.erb'),
      order   => '02',
    }
  }
}
