require 'spec_helper'
describe 'local_user::windows', :type => :define do
  let (:title) { 'rnelson0' }
  let (:params) do
    {
      :state    => 'present',
      :groups   => [],
      :password => 'Microsoft1',
    }
  end
  let (:facts) do
    {
      :kernel => "windows",
    }
  end

  context 'with defaults' do
    it { is_expected.to create_user('rnelson0').with({
      :comment          => 'rnelson0',
      :groups           => ['Remote Desktop Users'],
      :password         => 'Microsoft1'
    }) }
  end
  
  context 'with allow_rdp => false, admin => false, no groups' do
    let (:params) do
      {
        :state     => 'present',
        :groups    => [],
        :password  => 'Microsoft1',
        :admin     => false,
        :allow_rdp => false,
      }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment  => 'rnelson0',
      :groups   => [],
      :password => 'Microsoft1',
      })}
  end

  context 'with allow_rdp => true, admin => true, no groups' do
    let (:params) do
      {
        :state     => 'present',
        :password  => 'Microsoft1',
        :admin     => true,
        :allow_rdp => true,
      }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment  => 'rnelson0',
      :groups   => ['Administrators','Remote Desktop Users'],
      :password => 'Microsoft1',
      })}
  end

  context 'with allow_rdp => false, admin > true, no groups' do
    let (:params) do
      {
        :state     => 'present',
        :password  => 'Microsoft1',
        :admin     => true,
        :allow_rdp => false,
      }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment  => 'rnelson0',
      :groups   => ['Administrators'],
      :password => 'Microsoft1',
      })}
  end

  context 'with allow_rdp => false, admin => true, rnelson0 group' do
    let (:params) do
      {
        :state     => 'present',
        :groups    => ['rnelson0'],
        :password  => 'Microsoft1',
        :admin     => true,
        :allow_rdp => false,
      }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment  => 'rnelson0',
      :groups   => ['rnelson0','Administrators'],
      :password => 'Microsoft1',
      })}
  end

  context 'with allow_rdp => true, admin => true, rnelson0 group' do
    let (:params) do
      {
        :state     => 'present',
        :groups    => ['rnelson0'],
        :password  => 'Microsoft1',
        :admin     => true,
        :allow_rdp => true,
      }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment  => 'rnelson0',
      :groups   => ['rnelson0','Administrators','Remote Desktop Users'],
      :password => 'Microsoft1',
      })}
  end

  context 'with allow_rdp => false, admin => true, rnelson0 group' do
    let (:params) do
      {
        :state     => 'present',
        :groups    => ['rnelson0'],
        :password  => 'Microsoft1',
        :admin     => false,
        :allow_rdp => false,
      }
    end

    it { is_expected.to create_user('rnelson0').with({
      :comment  => 'rnelson0',
      :groups   => ['rnelson0'],
      :password => 'Microsoft1',
      })}
  end

  context 'fail on non-windows systems' do
    let (:facts) do
      {
        :kernel => "Linux",
      }
    end
    it { is_expected.to compile.and_raise_error(/Windows support only!/) }
  end
  
end
