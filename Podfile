source 'https://github.com/CocoaPods/Specs.git'
workspace 'RudderBugsnag.xcworkspace'
use_frameworks!
inhibit_all_warnings!
platform :ios, '13.0'


target 'SampleAppObjC' do
    project 'Examples/SampleAppObjC/SampleAppObjC.xcodeproj'
    pod 'RudderBugsnag', :path => '.'
end

target 'SampleAppSwift' do
    project 'Examples/SampleAppSwift/SampleAppSwift.xcodeproj'
    pod 'RudderBugsnag', :path => '.'
end

target 'RudderBugsnag' do
    project 'RudderBugsnag.xcodeproj'
    pod 'Rudder', '~> 2.0'
    pod 'Bugsnag', '6.16.4'
end
