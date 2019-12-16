require 'spec_helper'

describe 'Open Source Tests' do

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
    it { should contain 'logging:' }
    it { should contain 'output:' }
  end

  describe file('/etc/init.d/filebeat') do
    it { should exist }
  end

  if os[:family] == 'redhat'
    describe command('yum versionlock list | grep filebeat') do
      its(:stdout) { should_not match /filebeat/ }
    end
  elsif ['debian', 'ubuntu'].include?(os[:family])
    describe command('sudo apt-mark showhold | grep filebeat') do
      its(:stdout) { should_not match /filebeat/ }
    end
  end

end

