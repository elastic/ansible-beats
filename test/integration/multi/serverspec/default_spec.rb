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
    it { should contain 'logging:' }
    it { should contain 'output:' }
  end

  describe file('/etc/init.d/filebeat') do
    it { should exist }
  end

  describe service('metricbeat') do
    it { should be_running }
  end

  describe package('metricbeat') do
    it { should be_installed }
  end

  describe file('/etc/metricbeat/metricbeat.yml') do
    it { should be_file }
    it { should be_owned_by 'root' }
  end

  describe file('/etc/metricbeat/metricbeat.yml') do
    it { should contain 'module: system' }
    it { should contain 'metricsets:' }
    it { should contain 'period: 10s' }
    it { should contain 'processes:' }
    it { should contain 'cpu_ticks:' }
    it { should contain 'logging:' }
    it { should contain 'output:' }
  end

  describe file('/etc/init.d/metricbeat') do
    it { should exist }
  end


end

