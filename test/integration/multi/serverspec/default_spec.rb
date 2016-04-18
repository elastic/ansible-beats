require 'spec_helper'

describe 'Multi Tests' do

  describe service('filebeat') do
    it { should be_running }
  end

  describe package('filebeat') do
    it { should be_installed }
  end

  describe file('/etc/filebeat/filebeat.yml') do
    it { should be_file }
    it { should be_owned_by 'root' }
  end

  describe file('/etc/filebeat/filebeat.yml') do
    it { should contain 'filebeat:' }
    it { should contain 'shipper:' }
    it { should contain 'logging:' }
    it { should contain 'output:' }
  end

  describe file('/etc/init.d/filebeat') do
    it { should exist }
  end

  describe service('topbeat') do
    it { should be_running }
  end

  describe package('topbeat') do
    it { should be_installed }
  end

  describe file('/etc/topbeat/topbeat.yml') do
    it { should be_file }
    it { should be_owned_by 'root' }
  end

  describe file('/etc/topbeat/topbeat.yml') do
    it { should contain 'input:' }
    it { should contain 'period: 10' }
    it { should contain 'stats:' }
    it { should contain 'system: true' }
    it { should contain 'process: true' }
    it { should contain 'filesystem: true' }
    it { should contain 'cpu_per_core: false' }
    it { should contain 'shipper:' }
    it { should contain 'logging:' }
    it { should contain 'output:' }
  end

  describe file('/etc/init.d/topbeat') do
    it { should exist }
  end


end

