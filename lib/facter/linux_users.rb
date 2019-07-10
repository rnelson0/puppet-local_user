if Facter.value(:kernel) == 'Linux'
  mutex = Mutex.new

  # We store a list of users which are not an essential systems users here ...
  users = []

  Puppet::Type.type('user').instances.each do |user|
    mutex.synchronize do
      # Add user to list only if the user is not an essential system user ...
      users << user.name
    end
  end

  Facter.add('linux_users') do
    confine kernel: :linux
    setcode { users.sort.join(',') }
  end
end
