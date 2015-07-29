require 'spec_helper'

describe 'pm_profiler::install', :type => :class do
  context 'default package on SLES' do
    it { 
      should contain_package('pm_profiler').with_ensure('present')
      
      should contain_file('/etc/pm-profiler').with({
        'ensure'  => 'directory',
        'mode'    => '0755',
        'owner'   => 'root',
        'group'   => 'root',
        'require' => 'Package[pm-profiler]',
      })
    }
  end
end
