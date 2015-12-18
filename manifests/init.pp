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
  $comment,
  $groups,
  $password,
  $uid                 = undef,
  $last_change         = 0,
  $password_max_age    = 90,
  $shell               = '/bin/bash',
  $home                = "/home/${name}",
  $ssh_authorized_keys = [],
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
    validate_re("${last_change}", '^(\d+|\d+-\d+-\d+)$') #lint:ignore:only_variable_string
    validate_integer($password_max_age)
    validate_string($home)
    if ($uid) {
      validate_integer($uid)
    }
    user { $name:
      ensure           => $state,
      shell            => $shell,
      home             => $home,
      comment          => $comment,
      managehome       => true,
      groups           => $groups,
      password_max_age => $password_max_age,
      uid              => $uid,
    }
    if ($ssh_authorized_keys) {
      local_user::ssh_authorized_keys{$ssh_authorized_keys:
        user => $name,
      }
      User[$name] -> Local_user::Ssh_authorized_keys[$ssh_authorized_keys]
    }

    case $::osfamily {
      'RedHat':  {
        $action = "/bin/sed -i -e 's/${name}:!!:/${name}:${password}:/g' /etc/shadow; chage -d ${last_change} ${name}"
      }
      'Debian':  {
        $action = "/bin/sed -i -e 's/${name}:x:/${name}:${password}:/g' /etc/shadow; chage -d ${last_change} ${name}"
      }
      default: { }
    }

    exec { "set ${name}'s password":
      command => $action,
      path    => '/usr/bin:/usr/sbin:/bin',
      onlyif  => "egrep -q  -e '${name}:!!:' -e '${name}:x:' /etc/shadow",
      require => User[$name],
    }
  }

}
