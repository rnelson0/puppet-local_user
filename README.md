# local_user

[![Build Status](https://travis-ci.org/rnelson0/puppet-local_user.png?branch=master)](https://travis-ci.org/rnelson0/puppet-local_user)
[![Puppet Forge](http://img.shields.io/puppetforge/v/rnelson0/local_user.svg)](https://forge.puppetlabs.com/rnelson0/local_user)
[![Puppet Forge Downloads](http://img.shields.io/puppetforge/dt/rnelson0/local_user.svg)](https://forge.puppetlabs.com/rnelson0/local_user)
[![Stories in Ready](https://badge.waffle.io/rnelson0/puppet-local_user.svg?label=ready&title=Ready)](http://waffle.io/rnelson0/puppet-modules)
[![Stories In Progress](https://badge.waffle.io/rnelson0/puppet-local_user.svg?label=in progress&title=In Progress)](http://waffle.io/rnelson0/puppet-modules)

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)

## Overview

This module provides a defined type, local_user, that wraps the puppet 'user'
resource type with validation. You may also provide a initial password that is
set only when the user has no password, as a brand new 'user' resource puppet
creates will have. This allows users to maintain their own passwords after
creation.

## Usage

Create a local user by providing at a minimum the user name, state, comment,
groups, and initial password:

    local_user { 'rnelson':
      state            => 'present',
      comment          => 'Rob Nelson',
      groups           => ['rnelson0', 'wheel'],
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
      last_change      => '2015-01-01',
      password         => 'encryptedstring',
      password_max_age => 90,
      ssh_authorized_keys => ['ssh-rsa AAAA...123 user@host'],
    }

Note: The encrypted string is processed via sed using '/' seperators. You MUST
escape any '/' characters.

If the specified groups do not exist and or not created elsewhere in your catalog (or ordered incorrectly), you will receive errors preventing the user from being created.

    Error: Could not create user rnelson0: Execution of '/usr/sbin/useradd -c Rob Nelson -g rnelson0 -G wheel -d /home/rnelson0 -s /bin/bash -m rnelson0' returned 6: useradd: group 'rnelson0' does not exist

Set the parameter `manage_groups` to `true` and the groups will be managed and ordered within `local_user`.
