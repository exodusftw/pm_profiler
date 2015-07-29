require 'spec_helper'

describe 'pm_profiler', :type => :class do
  context 'default parameters on SLES' do
    let (:facts) {{
      :operatingsystem => 'SLES',
    }}
    it { 
      should contain_class('pm_profiler::install')
      should contain_class('pm_profiler::config')
      should contain_class('pm_profiler::service')
    }
  end
end
