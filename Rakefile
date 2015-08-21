require 'rake'
require 'puppet-lint/tasks/puppet-lint'
require 'puppet-syntax/tasks/puppet-syntax'

exclude_paths = [
  'spec/**/*',
  'pkg/**/*',
  'tests/**/*'
]

PuppetSyntax.exclude_paths = exclude_paths
PuppetLint.configuration.fail_on_warnings
PuppetLint.configuration.with_context = true
PuppetLint.configuration.relative = true

task :default => [:lint]
