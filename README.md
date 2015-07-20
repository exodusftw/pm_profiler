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
9. [Change Log](https://github.com/exodusftw/puppet-ovpa/tree/master/CHANGELOG.md)

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

* `placeholder`:
  * Agent Config Variable 
    * Namespace: ``
    * Variable: ``

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
  placeholder => $pm-profiler::params::placeholder ,
}
```

### ENC Setup
Overrides are available for:
* `pm_profiler_version` - Defaults to `latest`
  * To force installation of latest version - ensure latest RPM's are present in backend YUM/SMT Repo
  * Configure necessary Matcher values in ENC and set value to: `latest`

## Reference

### Classes and Parameters
* `pm-profiler`: The main module class [Code Detail](https://github.com/exodusftw/puppet-ovpa/tree/master/manifests/init.pp)
  * `policy_server`: Sets the Agent Config Variable for: `MANAGER` to register with proper management system
* `pm-profiler::params`: Default Params class [Code Detail](https://github.com/exodusftw/puppet-ovpa/tree/master/manifests/params.pp)
* `pm-profiler::proc`: Manages and Ensures Agent process are running [Code Detail](https://github.com/exodusftw/puppet-ovpa/tree/master/manifests/proc.pp)

### Defined Types Provided
None

### Facts Provided
* Facts - [Additional Code Detail](https://github.com/exodusftw/puppet-pm-profiler/tree/master/lib/facter/opcagtfacts.rb)
  * `default_pm_profile`: Default pm-profile to load on boot

## Limitations

Tested on:
* SLES 10sp4
* SLES 11 (SP1, SP2, SP3)
* SLES 12

## Development
No special development requirements

## Authors

* Jeremy Grant <Jeremy.Grant@outlook.com>

