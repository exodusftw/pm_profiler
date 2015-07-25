# == Class: pm_profiler
define pm_profiler::pm_config (
  $cpu_governor              = '',
  $description               = '',
  $dirty_writeback_centisecs = 0 ,
  $external_hook             = '',
  $hal_disable_polling       = 0 ,
  $ondemand_powersave_bias   = 1 ,
  $ondemand_sampling_rate    = '',
  $ondemand_up_threshold     = '',
  $power_button_hook         = '',
  $power_savings             = '',
  $read_ahead_kb             = 128 ,
  $sata_alpm                 = '',
) {

  include ::stdlib

  #BEGIN PARAMETER VALIDATIONS
  validate_string($name)

  validate_re($cpu_governor, '^(powersave|performance|ondemand|userspace)$',
    "cpu_governor value: ${cpu_governor} is invalid. Valid values are: 'powersave', 'performance', 'ondemand', 'userspace'")
  
  validate_string($description)
  
  validate_integer($dirty_writeback_centisecs, '', 0)
  
  validate_absolute_path($external_hook)
  
  validate_integer($hal_disable_polling, 1, 0)
  
  validate_integer($ondemand_powersave_bias, 1000, 1)
  
  validate_integer($ondemand_sampling_rate,
    "ondemand_sampling rate value: ${ondemand_sampling_rate} is invalid. Must be an integer value")
  
  validate_integer($ondemand_up_threshold,
    "ondemand_up_threshold value: ${ondemand_up_threshold} is invalid. Must be an integer value")
  
  validate_string($power_button_hook)
  
  validate_integer($power_savings, 1, 0)
  
  validate_integer($read_ahead_kb, '', 0)
  
  validate_re($sata_alpm, '^(min_power|max_performance|medium_power)$',
    "sata_alpm value: ${sata_alpm} is invalid. Valid values are: 'min_power', 'max_performance', 'medium_power'")
  #END OF PARAMETER VALIDATIONS


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
