# == Define: local_user
#
# Definition for a local user
#
# === Examples
#
#  local_user { 'username':
#    state               => 'present',
#    shell               => '/bin/bash',
#    home                => '/home/username',
#    comment             => 'Real Name',
#    groups              => ['group1', 'group2'],
#    uid                 => 2001,
#    password            => 'encryptedstring',
#    password_max_age    => 90,
#    last_change         => '2015-01-01',
#    ssh_authorized_keys => ['ssh-rsa AAAA...123 user@host'],
#    manage_groups       => true,
#  }
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2014 Rob Nelson
#
define local_user (
  $state,
  $groups,
  $password            = '*',
  $comment             = $name,
  $uid                 = undef,
  $gid                 = $name,
  $last_change         = 0,
  $password_max_age    = 90,
  $shell               = '/bin/bash',
  $home                = "/home/${name}",
  $managehome          = true,
  $ssh_authorized_keys = [],
  $manage_groups       = false,
  $system              = false,
) {
  validate_string($name)
  validate_string($state)
  if ($state == 'absent') {
      user { $name:
      ensure => $state,
    }
  }
  else {
    validate_re($shell, '^/.*/.*')
    validate_string($comment)
    validate_array($groups)
    validate_string($password)
    validate_bool($managehome)
    validate_re("${last_change}", '^(\d+|\d+-\d+-\d+)$') #lint:ignore:only_variable_string
    validate_integer($password_max_age)
    validate_string($home)
    validate_string($gid)
    validate_bool($system)
    if ($uid) {
      validate_integer($uid)
    }

    if ($manage_groups) {
      #Set groups to check for
      case $manage_groups {
        true, 'enabled':  {
          $managed_groups = unique([$groups, $gid])
        }
        'primary','gid':  {
          $managed_groups = [$gid]
        }
        false, 'disabled': {
          $managed_groups = undef
        }
        default: { fail() }
      }
      #Check for groups. Create them if array exists.
      if ($managed_groups) {
        group { $managed_groups:
          ensure => present,
          before => User[$name],
        }
      }
    }

    if ($name in $::linux_users) {
        user { $name:
          ensure           => $state,
          shell            => $shell,
          home             => $home,
          comment          => $comment,
          managehome       => $managehome,
          groups           => $groups,
          password_max_age => $password_max_age,
          uid              => $uid,
          gid              => $gid,
          system           => $system,
        }
    } else {
        user { $name:
          ensure           => $state,
          shell            => $shell,
          home             => $home,
          comment          => $comment,
          managehome       => $managehome,
          groups           => $groups,
          password_max_age => $password_max_age,
          password         => $password,
          uid              => $uid,
          gid              => $gid,
          system           => $system,
        }
    }

    if ($ssh_authorized_keys) {
      local_user::ssh_authorized_keys{$ssh_authorized_keys:
        user => $name,
      }
      User[$name] -> Local_user::Ssh_authorized_keys[$ssh_authorized_keys]
    }

  }

}
