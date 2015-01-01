# local_user

#### Table of Contents

1. [Overview](#overview)
4. [Usage - Configuration options and additional functionality](#usage)

## Overview

This module provides a defined type, local_user, that wraps the puppet 'user'
resource type with validation. You may also provide a initial password that is
set only when the user has no password, as a brand new 'user' resource puppet
creates will have. This allows users to maintain their own passwords after
creation.

## Usage

Create a local user by providing at a minimum the user name, state, comment,
groups, and initial password:

    local_user { 'username':
      state            => 'present',
      comment          => 'Real Name',
      groups           => ['group1', 'group2'],
      password         => 'encryptedstring',
    }

You may also provide the shell, home directory, password max age, and the last
change date (YYYY-MM-DD or number of days since Jan 1, 1970). These values
default to /bin/bash, /home/<username>, 90 days, and 0 days, respectively.

    local_user { 'username':
      state            => 'present',
      shell            => '/bin/bash',
      home             => '/home/username',
      comment          => 'Real Name',
      groups           => ['group1', 'group2'],
      last_change      => '2015-01-01',
      password         => 'encryptedstring',
      password_max_age => 90,
    }

Note: The encrypted string is processed via sed using '/' seperators. You MUST
escape any '/' characters.
