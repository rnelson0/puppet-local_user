# Local User - Windows Edition
#
# DESCRIPTION:
# WIP - Allows you to set local users and RDP access via Puppet (for now...)
#  
# USAGE: 
# local_user::windows { 'steve' :
#   state     => present|absent, # currently set to present or absent
#   password  => <your password>, # a plain text password
#   comment   => "Full Name", # user's full name
#   groups    => <string or array of groups>, # add user to groups
#   allow_rdp => true|false,  # grant user rdp access
#   admin     => true|false,  # add user to Administrators group
# }
#
# local_user::windows { 'bob' :
#   state     => present,
#   password  => 'Bobbo1234',
#   groups    => ['Administrators'],
#   comment   => 'Bob is Cool',
#   allow_rdp => true,
# }

define local_user::windows (
  $state,
  $password,
  $groups = [],
  $admin = false,
  $comment = $name,
  $allow_rdp = true,
) {

  if $::kernel != 'windows' {
    fail('Windows support only!')
  }

  # With default params, users receive RDP access
  if $admin == false and $allow_rdp == true {
    $group_array = ['Remote Desktop Users']
  }
  if $admin == true and $allow_rdp == true {
    $group_array = ['Administrators', 'Remote Desktop Users']
  }
  if $admin == true and $allow_rdp == false {
    $group_array = ['Administrators']
  }
  if $admin == false and $allow_rdp == false {
    $group_array = []
  }
  
  $grouplist = concat($groups,$group_array)

  user { $name:
      ensure   => $state,
      comment  => $comment,
      groups   => $grouplist,
      password => $password,
  }

}
