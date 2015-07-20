# == Class: pm_profiler::config
class pm_profiler::config (
) inherits pm_profiler {

  #Management of default pm-profiler config file
  file { '/etc/pm-profiler.conf':
    ensure  => file,
    content => template('pm_profiler/pm_profiler.conf.erb'),
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    notify  => Service['pm_profiler'],
  }
}
