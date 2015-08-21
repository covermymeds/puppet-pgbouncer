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
An array of entries to be written to the databases section in the pbbouncer.ini

Array entry format in hieradata:

```
  pgbouncer::params::databases:
    - 'postgres = host=localhost    dbname=postgres'
    - 'admin    = host=localhost    dbname=admin'
```

#####`auth_list`
An array of auth values (user/password pairs).
This array is written to /var/lib/postgresql/pgbouncer.auth line by line.

Array entry format in hieradata:

```
  pgbouncer::params::auth_list:
    - '"user" "password"'
    - '"user2" "password2"'
```

####`pgbouncer_package_name`
Name of the package to install.  This should default to your distributions package automatically, but could be used to specify a specific version.

## Limitations

This has only been tested on Redhat Systems. If you expereience issues using it with Ubuntu, please open an issue and we will work with you to correct the problem.

## Development

The module is open source and available on github.  Please fork!
