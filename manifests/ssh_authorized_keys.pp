# == Define: local_user::ssh_authorized_key
#
# Defined type that generates an ssh_authorized_key resource for a local_user resource
#
# === Examples
#
#  local_user::ssh_authorized_key { 'ssh-rsa AAAA...123 user@host': }
#
# === Authors
#
# Rob Nelson <rnelson0@gmail.com>
#
# === Copyright
#
# Copyright 2015 Rob Nelson
#
define local_user::ssh_authorized_keys (
  $user = undef
) {
  $split = split($name, ' ')
  $ssh_authorized_key_type  = $split[0]
  $ssh_authorized_key_key   = $split[1]
  $ssh_authorized_key_name  = $split[2]
  $ssh_authorized_key_title = "${user}_${ssh_authorized_key_type}_${ssh_authorized_key_name}"

  ssh_authorized_key { $ssh_authorized_key_title:
    ensure => present,
    user   => $user,
    type   => $ssh_authorized_key_type,
    key    => $ssh_authorized_key_key,
    name   => $ssh_authorized_key_name,
  }
}
