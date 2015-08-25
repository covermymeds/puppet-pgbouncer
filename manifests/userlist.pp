define pgbouncer::userlist ( 
  $auth_list = [],
) {

  validate_array($auth_list)

  #notify{"The defined type value is: ${userlist_file}": }
  
  concat::fragment { "$auth_list[0]['user']":
    target  => '/etc/pgbouncer/userlist.txt',
    content => template('pgbouncer/userlist.txt.erb'),
    order   => '01',
  }
}
