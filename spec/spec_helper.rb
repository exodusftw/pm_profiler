require 'rspec-puppet'

fixture_path = File.expand_path(File.join(__FILE__,'..','fixtures'))

RSpec.configure do |c|
  c.module_path = File.expand_path(File.join(__FILE__, '..', 'fixtures', 'modules'))
  c.manifest_dir = File.expand_path(File.join(__FILE__, '..', 'fixtures', 'manifests'))
end
