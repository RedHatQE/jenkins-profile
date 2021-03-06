# frozen_string_literal: true

title 'vitals'
ports = attribute(
  'ports',
  value: ['8080'],
  description: 'Ports that Jenkins listening on'
)

jenkins_url = attribute(
  'jenkins_url',
  value: 'http://localhost:8080',
  description: 'Jenkins URL'
)

control 'vital-1.0' do
  impact 1.0
  title 'Port connections'
  desc 'Ports are open and listening, meaning something is working'
  ports.each do |port|
    describe port(port) do
      it { should be_listening }
    end
  end
end

control 'vital-2.0' do
  impact 1.0
  title 'Jenkins process'
  desc 'The Jenkins process is running'
  describe processes('jenkins') do
    it { should exist }
  end
end

control 'vital-3.0' do
  impact 1.0
  title 'Web interface'
  desc 'The Jenkins process has a working web interface'
  describe http(jenkins_url) do
    its('status') { should cmp 200 }
    its('body') { should include 'Jenkins' }
  end
end
