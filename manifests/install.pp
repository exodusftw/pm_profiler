#Class - pm_profiler::install
class pm_profiler::install (
) inherits pm_profiler{

  package { 'pm-profiler':
    ensure => $pm_profiler::pm_profiler_version,
    notify => Service['pm-profiler'],
  }
}
