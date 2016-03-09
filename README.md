# local_user

[![Build Status](https://travis-ci.org/rnelson0/puppet-local_user.png?branch=master)](https://travis-ci.org/rnelson0/puppet-local_user)
[![Puppet Forge](http://img.shields.io/puppetforge/v/rnelson0/local_user.svg)](https://forge.puppetlabs.com/rnelson0/local_user)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/rnelson0/local_user.svg)](https://forge.puppetlabs.com/rnelson0/local_user)
[![Stories in Ready](https://badge.waffle.io/rnelson0/puppet-local_user.svg?label=ready&title=Ready)](http://waffle.io/rnelson0/puppet-modules)
[![Stories In Progress](https://badge.waffle.io/rnelson0/puppet-local_user.svg?label=in progress&title=In Progress)](http://waffle.io/rnelson0/puppet-modules)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
    * [Resource Definition](#resource-definition)
    * [Via Hiera](#via-hiera)
3. [Caveats and Clarifications](#caveats-and-clarifications)


## Overview

This module provides a defined type, local_user, that wraps the puppet 'user'
resource type with validation. You may also provide a initial password that is
set only when the user has no password, as a brand new 'user' resource puppet
creates will have. This allows users to maintain their own passwords after
creation.

## Usage

### Resource Definition

Create a local user by providing at a minimum the user name, state,
groups, and initial password:

    local_user { 'rnelson':
      state            => 'present',
      groups           => ['group1', 'group2'],
      password         => 'encryptedstring',
    }

You may also provide the shell, home directory, password max age, the last
change date (YYYY-MM-DD or number of days since Jan 1, 1970), and an array of ssh keys. These values
default to /bin/bash, /home/<username>, 90 days, 0 days, and null, respectively.

    local_user { 'rnelson':
      state            => 'present',
      shell            => '/bin/bash',
      home             => '/home/rnelson0',
      managehome       => true,
      comment          => 'Rob Nelson',
      groups           => ['rnelson0', 'wheel'],
      gid              => 'rnelson0'
      manage_groups    => true,
      last_change      => '2015-01-01',
      password         => 'encryptedstring',
      password_max_age => 1000,
      ssh_authorized_keys => ['ssh-rsa AAAA...123 user@host'],
    }

Starting with v1.0.8, a new `local_user::windows` type is available.
The user can be given access to the administrator or remote desktop user groups with the parameters `$admin` (default false) and `$allow_rdp` (default true).
It shares the common parameters of `$state`, `$password`, `$groups`, and `$comment`.
Unlike the unix version of `local_user`, the password is unencrypted and will be reset on every run.

    local_user::windows { 'bob' :
      state     => present,
      password  => 'Bobbo1234',
      groups    => ['Administrators'],
      comment   => 'Bob is Cool',
      allow_rdp => true,
    }

### Via Hiera

You can also store your user information in hiera and use the `create_resources()` function to create the users. The user(s) can be defined in the appropriate level(s) of your hierarchy, for example at the least-specific level, `global.yaml`:

````
# global.yaml
---
local_users:
  rnelson0:
    state:            'present'
    home:             '/home/rnelson0'
    managehome:       true
    comment:          'Rob Nelson'
    groups:
      - 'rnelson0'
      - 'wheel'
    gid:              'rnelson0'
    manage_groups:    true
    last_change:      '2015-01-01'
    password:         'encryptedstring'
    password_max_age: '1000'
    ssh_authorized_keys:
      - 'ssh-rsa AAAA...123 user@host'
````

Add code similar to the following black to a common class, such as `profile::base`. The result of the hiera lookup for `local_users`, using your hiera merge strategy, will be discovered and added to the node's manifest.

````
# profile/manifests/base.pp
class profile::base {
  # Your base profile goes here

  $local_users = hiera('local_users', undef)
  if ($local_users) {
    create_resources('local_user', $local_users)
  }
}
````

This example is functionally equivalent to the second [Resource Definition](#resource-definition) example.

## Caveats and Clarifications

* When no `$comment` is provided, the comment field will contain the username.

* The encrypted string is processed via sed using '/' seperators. You MUST escape any '/' characters.

* If the specified groups do not exist and or not created elsewhere in your catalog (or ordered incorrectly), you will receive errors preventing the user from being created. Set the parameter `manage_groups` to `true` and the groups will be managed and ordered within `local_user`. The error looks like:
````
Error: Could not create user rnelson0: Execution of '/usr/sbin/useradd -c Rob Nelson -g rnelson0 -G wheel
-d /home/rnelson0 -s /bin/bash -m rnelson0' returned 6: useradd: group 'rnelson0' does not exist
````
