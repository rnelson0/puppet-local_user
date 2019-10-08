require 'spec_helper_acceptance'

describe 'Local user' do
  context 'named rnelson0' do
    return unless os[:family] != 'windows'
    it do
      pp = <<-PUPPETCODE
        local_user{ 'rnelson0':
          state => present,
          groups => ['wheel'],
          password => 'asdf',
          manage_groups => true,
        }
      PUPPETCODE

      idempotent_apply(pp)
    end

    describe file('/etc/passwd') do
      its(:content) { is_expected.to contain %r{^rnelson0:x} }
    end
  end
end
