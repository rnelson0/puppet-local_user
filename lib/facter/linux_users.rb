if Facter.value(:kernel) == 'Linux'
  mutex = Mutex.new

  # We store a list of users which are not an essential systems users here ...
  users = []

  Puppet::Type.type('user').instances.each do |user|
    # Get details about the user from the corresponding instance ...
    instance = user.retrieve

    mutex.synchronize do
      # Add user to list only if the user is not an essential system user ...
      users << user.name unless instance[user.property(:uid)].to_i < 1000
    end
  end

  Facter.add('linux_users') do
    confine :kernel => :linux
    setcode { users.sort.join(',') }
  end
end
