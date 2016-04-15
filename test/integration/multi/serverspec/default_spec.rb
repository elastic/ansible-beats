require 'spec_helper'

describe 'Standard Tests' do

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

  describe file('/etc/default/filebeat') do
    it { should exist }
  end

  describe file('/usr/lib/systemd/system/filebeat.service') do
    it { should exist }
  end

end

