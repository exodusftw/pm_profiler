# == Class: pm_profiler
#
# Managed configuration for SUSE power management profiles
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# Jeremy Grant <Jeremy.Grant@outlook.com>
#
class pm_profiler (
  $pm_profiler_version = $pm_profiler::params::pm_profiler_version ,
) inherits pm_profiler::params {

  include ::stdlib

  if $::operatingsystem == 'SLES' {
    include ::pm_profiler::install
    include ::pm_profiler::config
    include ::pm_profiler::service
    Class['pm_profiler::install'] ->
    Class['pm_profiler::config'] ->
    Class['pm_profiler::service']
  }
  else {
    #FAIL DUE TO UNKNOWN OS
    fail 'SLES only supported os for pm_profiler'
  }
}
