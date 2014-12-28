require 'spec_helper'
describe 'local_user' do

  context 'with defaults for all parameters' do
    it { should contain_class('local_user') }
  end
end
