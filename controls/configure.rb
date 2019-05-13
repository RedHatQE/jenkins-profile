title 'Jenkins configuration'

jenkins_home = attribute(
  'jenkins_home',
  value: '/var/lib/jenkins',
  description: 'Jenkins home'
)
plugins = attribute(
  'jenkins_plugins',
  value: [],
  description: 'Jenkins plugins'
)
settings = attribute(
  'jenkins_settings',
  value: [],
  description: 'Jenkins settings'
)

control 'config-01' do
  title 'jenkins plugins'
  describe file(jenkins_home + '/plugins') do
    it { should be_directory }
    its('group') { should eq 'jenkins' }
    its('owner') { should eq 'jenkins' }
  end
  plugins.each do |plugin|
    describe file(jenkins_home + '/plugins/' + plugin + '.jpi') do
      it { should be_file }
      its('group') { should eq 'jenkins' }
      its('owner') { should eq 'jenkins' }
    end
  end
end

control 'config-02' do
  title 'Jenkins application settings'
  describe xml(jenkins_home + '/config.xml') do
    settings.each do |setting|
      its(setting['key']) { should eq setting['value'] }
    end
  end
end
