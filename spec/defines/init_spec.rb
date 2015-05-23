require 'spec_helper'
describe 'local_user' do
  let (:title) { 'rnelson0' }
  let (:params) do
  {
    :state    => 'present',
    :comment  => 'Rob Nelson',
    :groups   => ['group1', 'group2'],
    :password => 'encryptedstring',
  }
  end

  context 'using minimum params' do
    it { is_expected.to create_user('rnelson0').with({
      :comment          => 'Rob Nelson',
      :shell            => '/bin/bash',
      :home             => '/home/rnelson0',
      :groups           => ['group1', 'group2'],
      :password_max_age => 90,
    }) }
  end

  context 'using full params' do
    let (:params) do
    {
      :state               => 'present',
      :comment             => 'Rob Nelson',
      :shell               => '/bin/zsh',
      :home                => '/nfshome/rnelson0',
      :groups              => ['group1', 'group2'],
      :password            => 'encryptedstring',
      :password_max_age    => 120,
      :ssh_authorized_keys => ['ssh-rsa AAAA...zwE1 rsa-key-20141029'],
    }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment          => 'Rob Nelson',
      :shell            => '/bin/zsh',
      :home             => '/nfshome/rnelson0',
      :groups           => ['group1', 'group2'],
      :password_max_age => 120,
    }) }
    it { is_expected.to create_local_user__ssh_authorized_keys('ssh-rsa AAAA...zwE1 rsa-key-20141029') }
  end
end
