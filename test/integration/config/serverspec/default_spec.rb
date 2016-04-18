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
    it { should contain 'packetbeat:' }
    it { should contain 'shipper:' }
    it { should contain 'logging:' }
    it { should contain 'output:' }
    #COMPLETE CONTENT TESTS
  end

  describe file('/etc/init.d/packetbeat') do
    it { should exist }
  end

end

