# openssh Cookbook CHANGELOG

This file is used to list changes made in each version of the openssh cookbook.

## 2.11.12 - *2024-05-23*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 2.11.11 - *2024-05-03*

## 2.11.10 - *2024-05-03*

## 2.11.9 - *2024-03-18*

## 2.11.8 - *2024-03-17*

## 2.11.7 - *2024-03-12*

- fix sshd-keygen command location for Amazon Linux 2023

## 2.11.6 - *2023-12-21*

## 2.11.5 - *2023-09-29*

## 2.11.4 - *2023-09-11*

## 2.11.3 - *2023-08-05*

- resolved cookstyle error: attributes/default.rb:120:58 refactor: `Chef/RedundantCode/MultiplePlatformChecks`

## 2.11.2 - *2023-08-04*

Standardise files with files in sous-chefs/repo-management

## 2.11.1 - *2023-08-04*

- Disable PAM option on Windows

## 2.11.0 - *2023-08-01*

- Add Windows Support

## 2.10.18 - *2023-07-10*

## 2.10.17 - *2023-05-16*

## 2.10.16 - *2023-04-17*

## 2.10.15 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 2.10.14 - *2023-04-01*

## 2.10.13 - *2023-04-01*

## 2.10.12 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 2.10.11 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 2.10.10 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 2.10.9 - *2023-02-23*

Standardise files with files in sous-chefs/repo-management

## 2.10.8 - *2023-02-23*

Remove delivery

## 2.10.7 - *2023-02-16*

Standardise files with files in sous-chefs/repo-management

## 2.10.6 - *2023-02-14*

## 2.10.5 - *2023-02-14*

Standardise files with files in sous-chefs/repo-management

## 2.10.4 - *2022-12-08*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 2.10.3 - *2022-02-10*

- Standardise files with files in sous-chefs/repo-management

## 2.10.2 - *2022-02-08*

- Remove delivery folder

## 2.10.1 - *2022-02-01*

- Update tested platforms

## 2.10.0 - *2022-01-24*

- Improved sorting of Match objects in sshd_config

## 2.9.2 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 2.9.1 - *2021-06-01*

- Standardise files with files in sous-chefs/repo-management

## 2.9.0 - *2021-02-25*

- Sous Chefs Adoption
- Cookstyle fixes

## 2.8.1 (2019-10-03)

- Expand platform testing to the latest platforms - [@tas50](https://github.com/tas50)
- Move template files out of the default directory - [@tas50](https://github.com/tas50)
- Remove deprecated recipe and long_description metadata - [@tas50](https://github.com/tas50)
- Remove EOL opensuse platform from the metadata - [@tas50](https://github.com/tas50)
- Cookstyle fixes in the library - [@tas50](https://github.com/tas50)
- Add RHEL 8 docker container support - [@tas50](https://github.com/tas50)

## 2.8.0 (2019-05-06)

- This release greatly improves the default attributes on openSUSE/SLES systems
- Update test kitchen config - [@tas50](https://github.com/tas50)
- Add code owners file - [@tas50](https://github.com/tas50)
- Cookstyle fixes - [@tas50](https://github.com/tas50)
- Remove testing of EOL Ubuntu 14.04 - [@tas50](https://github.com/tas50)
- Move the service name to a helper - [@tas50](https://github.com/tas50)
- Fix the roaming test for Amazon Linux 2 - [@tas50](https://github.com/tas50)
- Add opensuseleap 15 testing and Chef 14 testing - [@tas50](https://github.com/tas50)
- Disable roaming on SLES 15 as well - [@tas50](https://github.com/tas50)
- Support generating ssh keys in opensuse 15 containers - [@tas50](https://github.com/tas50)
- Move use_roaming attribute default logic to a helper - [@tas50](https://github.com/tas50)
- Configure the subystem properly on SUSE platform family - [@tas50](https://github.com/tas50)
- Move ssh host key determination to a helper with SLES 15 support - [@tas50](https://github.com/tas50)
- Make sure we return true when supported - [@tas50](https://github.com/tas50)
- Modernize the specs for the new ChefSpec release - [@tas50](https://github.com/tas50)
- Add platform version helpers for readability - [@tas50](https://github.com/tas50)
- Default specs to 18.04 - [@tas50](https://github.com/tas50)
- Avoid FC warning - [@tas50](https://github.com/tas50)
- Disable opensuse 15 testing for now - [@tas50](https://github.com/tas50)

## 2.7.1 (2018-11-01)

- Add support for multiple subsystems
- Use template verify property instead of notify to handle configuration verification so we don't ever template out a non-functional config

## 2.7.0 (2018-07-24)

- Add support for array values under a host hash and added indentation for host values

## 2.6.3 (2018-03-19)

- Support Amazon Linux 2 in containers

## 2.6.2 (2018-03-02)

- Swap Chef 12 testing for Chef 14 testing
- Create the privilege separation directory on debian/ubuntu, which is not always there on Docker images
- Add Ubuntu 18.04 testing

## 2.6.1 (2017-11-30)

- Generate missing ssh keys on amazon linux as well. This impacts containers where ssh keys have not already been generated

## 2.6.0 (2017-10-18)

- Fixed trusted user CA key documentation
- Collapse the smartos hostkey attributes into the centos 6 attributes since they were the same values
- Make sure the hostkey attribute works when RHEL 8 comes out by not constraining the version check too much
- Run sshd-keygen on Fedora / CentOS 7 when host keys are missing. Why would keys be missing? Well if you've never run sshd then you don't have keys on RHEL/Fedora. This happens primarily when you try to Chef a container
- Add Testing on Chef 12 to Travis so we test both 12 and 13
- Move the flat helper methods into an actual library that is properly loaded

## 2.5.0 (2017-09-16)

- Added TrustedUserCAKeys and RevokedKeys support
- Enabled Foodcritic FC024 again
- Generate keys on systemd boxes before validating configs by starting sshd-keygen service if it exists. This prevents failures in docker
- Use multipackage installs to install client/server packages to speed up the chef run
- Add Debian 9 testing in Travis
- Add more platforms to Chefspecs, avoid deprecation warnings, and greatly speed up specs

## 2.4.1 (2017-05-22)

- Fix a bug that resulted in RHEL 6 cert paths being incorrect and expanded testing to check ssh login behavior not just config validation.

## 2.4.0 (2017-05-11)

- Config fixes for the sshd config on Amazon Linux
- Use the correct ssh host keys on RHEL 6
- Use the right sftp subsystem on Debian and Fedora
- Make sure the hostkeys are set on Debian/Ubuntu

## 2.3.1 (2017-04-20)

- Fix AIX service to skip enable since AIX does not support enable

## 2.3.0 (2017-04-19)

- Add basic AIX support

## 2.2.0 (2017-04-03)

- Test with Local Delivery instead of Rake
- Initial Amazon Linux support for Chef 13

## 2.1.1 (2017-01-03)

- Fix for sftp on rhel
- Add all supported SUSE releases to the readme and metadata

## 2.1.0 (2016-09-18)

- Add support for multiple sshd ports.
- Switch to kitchen-dokken for integration testing in Travis CI
- EL7 intentionally lacks of auto-gen'd DSA key
- Fix commented default for ciphers and macs
- Add chef_version metadata
- Remove hostnames from the templates
- Basic Mac OS support
- Avoid node.set deprecation warnings
- Require Chef 12.1+
- Fix inspec tests
- Remove the service provider logic that isn't necessary in Chef 12
- Set the sftp subsystem on Ubuntu

## 2.0.0 (2016-03-18)

- Don't set the Roaming No directive on RHEL systems before 7.0 as they ship with a sshd release which does not handle this directive
- Depend on the newer iptables cookbook, which bumps the required Chef release for this cookbook to 12.0+

## 1.6.1 (2016-01-20)

- Restored sshd restarting post config change

## 1.6.0 (2016-01-14)

- Removed the default['openssh']['rootgroup'] attribute and instead use root_group which was introduced in Chef 11.6.0
- UseRoaming no is now set in the client config to resolve CVE-2016-0777 and CVE-2016-0778
- Converted bats integration test to 2 suites of Inspec tests
- Added a libary to sort sshd_config entries while keeping port at the top to prevent sshd from failing to start

## 1.5.2 (2015-06-29)

- Use the complete path to sshd when verifying the config file since sbin may not be in the path

## 1.5.0 (2015-06-24)

- Perform a config syntax check before restarting the sshd so we don't break remote access to hosts
- Add support for Ubuntu 15.04+ with systemd
- Added a chefignore file
- Added Gitter badge for asking questions in a Gitter chat room

## 1.4.0 (2015-05-01)

- 42 - Fixed support for SmartOS
- 46 - Correct ArchLinux service name
- 43 - Correct OpenSSH server package name on RHEL, Fedora
- 31 - Allow included iptables rule to use the same port number if defined in attributes.
- 41 - Fix default recipe order
- 47 - Fix up iptables rule
- 49 - Fixed the print_last_log attribute in the Readme
- Updated Test Kitchen config with all supported platforms
- Updated Test Kitchen / Foodcritic / Rubocop / Berkshelf depedencies in the Gemfile
- Replaced Travis Ruby 1.9.3/2.0.0 testing with 2.1.5/2.2.0
- Resolved all Rubocop warnings

## v1.3.4 (2014-04-23)

- [COOK-4576] - No way to override `AuthorizedKeysFile`
- [COOK-4584] - Use Upstart on Ubuntu 12.04
- [COOK-4585] - skip match block in template if empty or unset
- [COOK-4586] OpenSSH Gentoo support

## v1.3.2

### Bug

- **[COOK-3995](https://tickets.chef.io/browse/COOK-3995)** - sshd_config template needs ordering
- **[COOK-3910](https://tickets.chef.io/browse/COOK-3910)** - ssh fails to start in Ubuntu 13.10
- **[COOK-2073](https://tickets.chef.io/browse/COOK-2073)** - Add support for Match block

## v1.3.0

### Improvement

- **[COOK-3644](https://tickets.chef.io/browse/COOK-3644)** - Add FreeBSD support
- **[COOK-2517](https://tickets.chef.io/browse/COOK-2517)** - Add hash support
- **[COOK-2000](https://tickets.chef.io/browse/COOK-2000)** - Make mode of sshd_config a configurable option

### Bug

- **[COOK-3558](https://tickets.chef.io/browse/COOK-3558)** - Fix RSA Server Config Options
- **[COOK-3557](https://tickets.chef.io/browse/COOK-3557)** - Fix PubkeyAuthentication option

## v1.2.2

### Bug

- **[COOK-3304](https://tickets.chef.io/browse/COOK-3304)** - Fix error setting Dynamic `ListenAddresses`

## v1.2.0

### Improvement

- [COOK-2647]: `port_ssh` iptables template has no corresponding recipe

## v1.1.4

- [COOK-2225] - Add platform_family suse

## v1.1.2

- [COOK-1954] - Fix attribute camel case to match `man sshd_config`
- [COOK-1889] - SSH restarting on each chef run due to template changes

## v1.1.0

- [COOK-1663] - Configurable ListenAddress based off list of interface names
- [COOK-1685] - Make default sshd_config value more robust

## v1.0.0

- [COOK-1014] - Templates for ssh(d).conf files.

## v0.8.1

- Current public release
