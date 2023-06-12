Pod::Spec.new do |s|
    s.name             = 'RudderBugsnag'
    s.version          = '1.1.0'
    s.summary          = 'Privacy and Security focused Segment-alternative. Bugsnag Native SDK integration support.'

    s.description      = <<-DESC
    Rudder is a platform for collecting, storing and routing customer event data to dozens of tools. Rudder is open-source, can run in your cloud environment (AWS, GCP, Azure or even your data-centre) and provides a powerful transformation framework to process your event data on the fly.
    DESC

    s.homepage         = 'https://github.com/rudderlabs/rudder-integration-bugsnag-swift'
    s.license          = { :type => "Apache", :file => "LICENSE" }
    s.author           = { 'RudderStack' => 'arnab@rudderlabs.com' }
    s.source           = { :git => 'https://github.com/rudderlabs/rudder-integration-bugsnag-swift.git', :tag => "v#{s.version}" }
    
    s.ios.deployment_target = '13.0'
    s.tvos.deployment_target = '11.0'
    s.osx.deployment_target = '10.13'
    
    s.source_files = 'Sources/**/*{h,m,swift}'
    s.module_name = 'RudderBugsnag'
    s.swift_version = '5.3'

    s.dependency 'Rudder', '~> 2.0'
    s.dependency 'Bugsnag', '6.16.4'
end
