# pgbouncer

## Overview
Installs and configures [pgbouncer](https://wiki.postgresql.org/wiki/PgBouncer).

## Module Description
This module installs the pgbouncer package and configures it to pool connections for postgresql databases.
By default, the service uses port 6432 as this is the default port of pgbouncer.

## Setup

### What pgbouncer affects

* /etc/pgbouncer/pgbouncer.ini
* /etc/pgbouncer/userlist.txt
* /etc/default/pgbouncer

### Setup Requirements 

Requires a Debian or RedHat based system. If other OS's are needed, it shouldn't be hard to extend the module.

## Usage

###Classes

This module modifies the pgbouncer configuration files and replaces the main configuration file.

####Class: `pgbouncer`

The primary class that installs and configures pgbouncer.  It also ensures the pgbouncer service is running.

####Class: pgbouncer::params

**Parameters within `pgbouncer`:**

#####`databases`
An array of hash entries to be written to the databases section in the pbbouncer.ini

Array entry format in hieradata:

```
  pgbouncer::databases:
    - source_db: 'admin'
      host: 'localhost'
      dest_db: 'admin'
      auth_user: 'admin'
```

#####`auth_list`
An array of hash values (user/password pairs).
This array is written to /var/lib/postgresql/pgbouncer.auth

Array entry format in hieradata:

```
  pgbouncer::userlist:
    - user: 'admin'
      password: 'admin'
```

## Limitations

This has only been tested on Redhat Systems. If you experience issues using it with Ubuntu, please open an issue and we will work with you to correct the problem or you can submit a PR.

## Development

The module is open source and available on github.  Please fork!
