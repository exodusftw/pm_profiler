# == Class: pm_profiler
#
define pm_profiler::config (
  $name                      = 'undef'
  $description               = 'undef'
  $cpu_governor              = 'undef'
  $power_savings             = 'undef'
  $sata_alpm                 = 'undef'
  $hal_disable_polling       = 'undef'
  $dirty_writeback_centisecs = 'undef'
  $read_ahead_kb             = 'undef'
) inherits pm_profiler::params {

  file { "/etc/pm-profiler/${name}":
    ensure => directory,
    owner  => 'root',
    group  => 'root', 
    mode   => '0644',
    require => [ Package['pm-profiler'], 
                  File['/etc/pm-profiler']
    ],
  }

  file { "/etc/pm-profiler/${name}/config":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    content => template('pm_profiler/pm_profile_type_config.erb'),
  }
}
