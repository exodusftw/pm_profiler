#Default parameters for the SUSE power management profiles
class pm_profiler::params {

  $required_rpms = [
    'pm_profiler' ,
  ]

  $active_pm_profile   = ''
  $pm_profiler_version = 'latest'

}
