require 'spec_helper'

describe 'Config Tests' do

  describe service('packetbeat') do
    it { should be_running }
  end

  describe package('packetbeat') do
    it { should be_installed }
  end

  describe file('/etc/packetbeat/packetbeat.yml') do
    it { should be_file }
    it { should be_owned_by 'root' }
  end

  describe file('/etc/packetbeat/packetbeat.yml') do
    it { should contain 'logging:' }
    it { should contain 'output:' }
    it { should contain 'protocols:' }
    it { should contain 'dns:' }
    it { should contain 'memcache:' }
    it { should contain 'http:' }
    it { should contain 'mongodb:' }
    it { should contain 'mysql:' }
    it { should contain 'pgsql:' }
    it { should contain 'redis:' }
    it { should contain 'thrift:' }
    it { should contain 'interfaces:' }
    it { should contain 'device: any' }
  end

  describe file('/etc/init.d/packetbeat') do
    it { should exist }
  end

  if os[:family] == 'redhat'
    describe command('yum versionlock list | grep packetbeat') do
      its(:stdout) { should match /packetbeat/ }
    end
  elsif ['debian', 'ubuntu'].include?(os[:family])
    describe command('sudo apt-mark showhold | grep packetbeat') do
      its(:stdout) { should match /packetbeat/ }
    end
  end

end

