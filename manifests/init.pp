# == Define: local_user
#
# Definition for a local user
#
# === Examples
#
#  local_user { 'username':
#    state            => 'present',
#    shell            => '/bin/bash',
#    home             => '/home/username',
#    comment          => 'Real Name',
#    groups           => ['group1', 'group2'],
#    password         => 'encryptedstring',
#    password_max_age => 90,
#    last_change      => '2015-01-01',
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
  $shell            = '/bin/bash',
  $home             = "/home/${name}",
  $comment,
  $groups,
  $last_change      = 0,
  $password_max_age = 90,
  $password,
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
    validate_string($last_change)
    validate_re($password_max_age, '^\d$')
    validate_string($home)

    user { $name:
      ensure           => $state,
      shell            => $shell,
      home             => $home,
      comment          => $comment,
      managehome       => true,
      groups           => $groups,
      password_max_age => $password_max_age,
    }

    case $::osfamily {
      RedHat:  {$action = "/bin/sed -i -e 's/${name}:!!:/${name}:${password}:/g' /etc/shadow; chage -d ${last_change} ${name}"}
      Debian:  {$action = "/bin/sed -i -e 's/${name}:x:/${name}:${password}:/g' /etc/shadow; chage -d ${last_change} ${name}"}
      default: { }
    }

    exec { "set $name's password":
      command => $action,
      path    => '/usr/bin:/usr/sbin:/bin',
      onlyif  => "egrep -q  -e '${name}:!!:' -e '${name}:x:' /etc/shadow",
      require => User[$name]
    }
  }
}
