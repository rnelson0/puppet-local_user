require 'spec_helper'
describe 'local_user::ssh_authorized_keys', :type => :define do
  let (:title) { 'ssh-rsa AAAA...zwE1 rsa-key-20141029' }
  let (:params) do
  {
    :user => 'rnelson0',
  }
  end

  context 'default' do
    it { is_expected.to create_ssh_authorized_key('rnelson0_ssh-rsa_rsa-key-20141029').with({
      :user  => 'rnelson0',
      :type  => 'ssh-rsa',
      :key   => 'AAAA...zwE1',
      :name  => 'rsa-key-20141029',
    }) }
  end
end
