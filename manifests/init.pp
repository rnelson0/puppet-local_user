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
  Enum['present','absent']                                    $state,
  Array[String]                                               $groups,
  String                                                      $password,
  String                                                      $comment             = $name,
  Optional[Variant[Integer, String]]                          $uid                 = undef,
  Variant[Integer, String]                                    $gid                 = $name,
  Variant[Integer, Pattern[/^\d+-\d+-\d+$/]]                  $last_change         = 0,
  Integer                                                     $password_max_age    = 90,
  Stdlib::AbsolutePath                                        $shell               = '/bin/bash',
  Stdlib::AbsolutePath                                        $home                = "/home/${name}",
  Boolean                                                     $managehome          = true,
  Array[String]                                               $ssh_authorized_keys = [],
  Variant[Boolean,Enum['enabled','primary','gid','disabled']] $manage_groups       = false,
  Boolean                                                     $system              = false,
) {
  if ($state == 'absent') {
      user { $name:
      ensure => $state,
    }
  }
  else {
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
