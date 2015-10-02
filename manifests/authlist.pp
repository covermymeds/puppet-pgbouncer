# == define: pgbouncer::authlist
#
# defined type that can be used to create the userlist in the auth_file
#
define pgbouncer::authlist(
  $auth_list = [],
) {

  validate_array($auth_list)

  concat::fragment { $auth_list[0]['user']:
    target  => $::pgbouncer::userlist_file,
    content => template('pgbouncer/userlist.txt.erb'),
    order   => '01',
  }
}
