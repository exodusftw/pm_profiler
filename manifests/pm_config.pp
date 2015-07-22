# == Class: pm_profiler
define pm_profiler::pm_config (
  $cpu_governor              = '',
  $description               = '',
  $dirty_writeback_centisecs = '',
  $external_hook             = '',
  $hal_disable_polling       = '',
  $ondemand_powersave_bias   = '',
  $ondemand_sampling_rate    = '',
  $ondemand_up_threshold     = '',
  $power_button_hook         = '',
  $power_savings             = '',
  $read_ahead_kb             = '',
  $sata_alpm                 = '',
) {

  file { "/etc/pm-profiler/${name}":
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [Package['pm-profiler'],
                File['/etc/pm-profiler'],
    ],
  }

  file { "/etc/pm-profiler/${name}/config":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('pm_profiler/pm_profile_type_config.erb'),
    require => File["/etc/pm-profiler/${name}"],
  }

  file_line { "set_profile_${name}":
    line    => "PM_PROFILER_PROFILE=${name}",
    path    => '/etc/pm-profiler.conf',
    match   => '^PM_PROFILER_PROFILE\=.*$',
    notify  => Service['pm-profiler'],
    require => [File["/etc/pm-profiler/${name}"],
                File["/etc/pm-profiler/${name}/config"],
    ],
  }
}
