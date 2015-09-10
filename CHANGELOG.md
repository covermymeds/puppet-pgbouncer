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
