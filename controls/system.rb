# frozen_string_literal: true

title 'system'
version = attribute(
  'version',
  value: '2.60.3-1.1',
  description: 'Jenkins version'
)
jenkins_home = attribute(
  'jenkins_home',
  value: '/var/lib/jenkins',
  description: 'Jenkins home'
)
control 'system-01' do
  title 'Jenkins Service'
  desc 'Jenkins service setup should be good'
  impact 0.8
  describe service('jenkins') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
  describe package('jenkins') do
    it { should be_installed }
    its('version') { should eq version }
  end
  describe yum do
    its('jenkins') { should exist }
    its('jenkins') { should be_enabled }
  end
  describe user('jenkins') do
    its('shell') { should eq '/bin/bash' }
  end
  describe file(jenkins_home) do
    it { should be_directory }
    its('group') { should eq 'jenkins' }
    its('owner') { should eq 'jenkins' }
  end
end
