#Class - pm_profiler::install
class pm_profiler::install (
) inherits pm_profiler{

  package { 'pm-profiler':
    ensure => $pm_profiler::pm_profiler_version,
    notify => Service['pm-profiler'],
  }
  
  file { '/etc/pm-profiler':
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => Package['pm-profiler'],
  }

}
