require 'spec_helper'

describe 'cutover::environment' do
  before(:all) do
    @puppetconf_location = '/etc/puppetlabs/puppet/puppet.conf'
  end

  context 'cutover::environment class logic' do
    describe 'should enforce the environment value in puppet.conf' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :environment => 'notmyenvironment',
        :environment_section => 'main',
      }}
      let(:facts) {{
        :kernel => 'Linux',
      }}

      it { should compile.with_all_deps }
      it { should contain_ini_setting('environment').with(
        'path' => @puppetconf_location,
        'section' => 'main',
        'value' => 'notmyenvironment',
        )
      }
    end
    
    describe 'should notify if called from external module' do
      let(:params) {{
        :puppet_conf => @puppetconf_location,
        :environment => 'notmyenvironment',
        :environment_section => 'main',
      }}
      let(:facts) {{
        :kernel => 'Linux',
        :module_name => 'foo',
        :caller_module_name => 'bar'
      }}

      it { should contain_cutover__private_warning('cutover::environment') }
    end
  end
end
