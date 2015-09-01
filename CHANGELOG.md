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
