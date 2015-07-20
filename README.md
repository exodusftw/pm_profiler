# pm-profiler

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
    * [What is managed](#what-is-managed)
      * [Files](#files)
      * [Packages](#packages)
      * [Services](#services)
      * [Other Resources](#other-resources)
    * [Dependencies](#dependencies)
3. [Usage - Configuration options and additional functionality](#usage)
    * [ENC configuration and overrides](#enc-setup)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes and parameters](#classes-and-parameters)
    * [Defined Types Provided](#defined-types-provided)
    * [Facts Provided](#facts-provided)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Extensibility](#extensibility)
8. [Authors](#authors)
9. [Change Log](https://github.com/exodusftw/puppet-pm-profiler/tree/master/CHANGELOG.md)

## Overview

Manages installation and configuration of SUSE power management profiles

To retrieve from Puppet Forge either:
* [Click Here](https://forge.puppetlabs.com/exodusftw/pm-profiler)
* Execute Command `puppet module install exodusftw-pm-profiler`

## Module Description

Manages the installation, configuration, and maintenance of the SUSE Enterprise Linux Power Management Profiles

**In order to get started with installation, ensure the Packages listed** [Here](#packages) **are available in your package manager of Choice:**

* `Preferred Package Managers`:
  * [Zypper](https://en.opensuse.org/Portal:Zypper)
  * [YUM](http://yum.baseurl.org/)
  * [YaST](https://en.opensuse.org/Portal:YaST)
  * [RUG](https://www.suse.com/documentation/sled10/sled_deployment_sp1/data/sec_onlineupdate_rug.html)

* `Preferred System Management Tools`:
  * [Spacewalk](http://spacewalk.redhat.com/)
  * [Red Hat Network Satellite](https://access.redhat.com/products/red-hat-satellite)
  * [SUSE Manager](https://www.suse.com/products/suse-manager/)

**Also - Please update the following variables for your environment as necessary in** [params.pp](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/params.pp)

* `active_pm_profile`: Power management profile to enable
* `pm_profiler_version`: Version of pm-profiler package to install - defaults to `present`

### What Is Managed

#### Files
* `/etc/pm-profiler.conf`

#### Packages
* `pm-profiler`

#### Services
* `pm-profiler`

#### Other Resources

* exec entries

### Dependencies
No dependent classes/modules required

## Usage
Example:
```puppet
class { 'pm-profiler':
  active_pm_profile   => 'low_latency' ,
  pm_profiler_version => 'latest',
}
```

### ENC Setup
Overrides are available for:
* `active_pm_profile` - Power management profile to activate
* `pm_profiler_version` - Defaults to `latest`
  * To force installation of latest version - ensure latest RPM's are present in backend YUM/SMT Repo
  * Configure necessary Matcher values in ENC and set value to: `latest`

## Reference

### Classes and Parameters
* `pm_profiler`: The main module class [Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/init.pp)
* `pm_profiler::params`: Default Params class [Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/params.pp)
* `pm_profiler::install`: Manages installation of `pm-profiler` package [Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/install.pp)
* `pm_profiler::config`: Manages configuration in `/etc/pm-profiler.conf` [Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/config.pp)
* `pm_profiler::service`: Manages and Ensures Agent process are running [Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/proc.pp)

### Defined Types Provided
* `pm_profiler::pm_config`: Enables creation and application of custom power management profile [Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/manifests/pm_config.pp)
* `available type attributes`:
  * `name`
  * `description`
  * `cpu_governor`
  * `read_ahead_kb`
  * `power_savings`
  * `sata_alpm`
  * `hal_disable_polling`
  * `dirty_writeback_centisecs`
  * `read_ahead_kb`

Example:
```puppet
pm_profiler::pm_config  {
  name                      => 'sap_hana',
  description               => 'Power management profile for sap_hana',
  cpu_governor              => 'performance',
  read_ahead_kb             => '',
  power_savings             => '',
  sata_alpm                 => '',
  hal_disable_polling       => '',
  dirty_writeback_centisecs => '',
  read_ahead_kb             => '',
}
```

### Facts Provided
None

## Limitations

Tested on:
* SLES 10sp4
* SLES 11 (SP1, SP2, SP3)
* SLES 12

## Development
No special development requirements

## Authors

* Jeremy Grant <Jeremy.Grant@outlook.com>

