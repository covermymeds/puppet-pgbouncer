## 2015-10-09 Release 0.3.0
### Summary
Better support for 1.7 release, possible impacting changes included!

### Changes
  - Changed default of global pooler to conservative value of session instead of the more aggressive transaction value. Though this is not a breaking change, it can affect performance greatly. To preserve the old behavior, please set overide the config params. Keep in mind this is a deep merge of the config_params variable with the defaults. Example hieradata below:

    ```
    pgbouncer::config_params
        pool_mode: 'transaction'
    ```
    Alternatively you can override the pool mode at the user level in 1.7 with the below syntax in your user array:

    ```
    pgbouncer::userlist:
      - user: 'username'
        password: 'password'
        pool_mode: 'transaction'
    ```
  - Optional arguments are added to the pgbouncer.ini databases section for port
  - Optional arguments are added to the pgbouncer.ini databases section for auth_user
  - Optional arguments are added to the pgbouncer.ini databases section for auth_pass
  - Optional arguments are added to the pgbouncer.ini databases section for pool_size
  - A users section has been added to the pgbouncer.ini 

## 2015-10-09 Release 0.2.7
### Summary
New OS Support and bugfix release

### Changes
 - Added FreeBSD OS support
 - Corrected issue that would have debian based systems trying to use yum
 - Corrected license definition in comments in init.pp

## 2015-09-10 Release 0.2.6
### Summary
Issue with a puppet lint error on forge

### Changes
 - Removed space from defined type to see if that fixes error that puppet-lint is not showing locally

## 2015-09-08 Release 0.2.5
### Summary
License change and bug-fix

### Changes
 - Fixed errors and warnings from puppet-lint
 - Changed license to GPL-3.0+ to reflect initial source

## 2015-09-03 Release 0.2.4
### Summary
Bug-fix release

### Changes
 - Changed version to match for release

## 2015-09-03 Release 0.2.3
### Summary
Bug-fix release

### Changes
 - Changed params on database list

## 2015-09-02 Release 0.2.2
### Summary
Bug-fix release

### Changes
 - Removed a comment line from userlist
 - Changed default storage location of pgbouncer log on rhel

## 2015-09-01 Release 0.2.1
### Summary
Bug-fix release

### Changes
 - Made entries into the userlist.txt file have the md5sum value of 'md5[password][username]' per the documentation

## 2015-08-26 Release 0.2.0
### Summary
Re-built module loosely based on https://bitbucket.org/landcareresearch/puppet-pgbouncer

### Changes
 - Changed license to MIT
 - Added Redhat support
 - Changed module so that all config parameters are managed by hash
 - Changed module to have templates for each section of config and build file using puppetlabs-concat
 - Changed module to use puppetlabs-postgresql module for repo management for pgbouncer
 - Set databases and authorized users be be built by defined types so they can be called from 3rd party modules
