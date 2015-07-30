require 'spec_helper'

describe 'pm_profiler::install', :type => :class do
  context 'default package on SLES' do
  let :facts do
    {
      :operatingsystem => 'SLES'
    }
  end
  it { 
      should contain_package('pm-profiler').with( { 'name' => 'pm-profiler' })
      
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
