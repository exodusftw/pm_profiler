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
  $power_savings             = 0 ,
  $read_ahead_kb             = '',
  $sata_alpm                 = '',
) {

  #BEGIN PARAMETER VALIDATIONS
  validate_string($name)

  validate_re($cpu_governor, '^(powersave|performance|ondemand|userspace)$',
    "cpu_governor value: ${cpu_governor} is invalid. Valid values are: 'powersave', 'performance', 'ondemand', 'userspace'")
  
  # Validate description is a string
  validate_string($description)
  
  # Match blank lines for default value - or centisec integer value
  validate_re($dirty_writeback_centisecs, '(^$|^\d*$)',
    "dirty_writeback_centisecs value: ${dirty_writeback_centisecs} is invalid. Must be an integer value or left blank for default value")
  
  # Validate absolute file path to external hook script
  validate_absolute_path($external_hook)
  
  # Match blank lines for default value - or values 1 and 0 to disable/enable
  validate_re($hal_disable_polling, '(^$|^1$|^0$)',
    "hal_disable_polling value: ${hal_disable_polling} is invalid. Must be either '1' to disable, '0' to enable, or left blank for default enabled value")
  
  # Match blank lines for default value - or any number between 1-1000
  validate_re($ondemand_powersave_bias, '(^$|^([1-9][0-9]{0,2}|1000)$)',
    "ondemand_powersave_bias value: ${ondemand_powersave_bias} is invalid. Must be an integer value between 1-1000 or left blank for default value")
  
  # Match blank lines for default value - or any number for sampling rate
  validate_re($ondemand_sampling_rate, '(^$|^\d*$)',
    "ondemand_sampling rate value: ${ondemand_sampling_rate} is invalid. Must be an integer value or left blank for default value")
  
  # Match blank lines for default value - or any number for threshold value
  validate_re($ondemand_up_threshold, '(^$|^\d*$)',
    "ondemand_up_threshold value: ${ondemand_up_threshold} is invalid. Must be an integer value or left blank for default value")
  
  validate_string($power_button_hook)
  
  validate_integer($power_savings, 1, 0)
  
  # Match blank lines for default value - or any number for read ahead KB value
  validate_re($read_ahead_kb, '(^$|^\d*$)',
    "read_ahead_kb value: ${read_ahead_kb} is invalid. Must be an integer value or left blank for default value")
  
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
