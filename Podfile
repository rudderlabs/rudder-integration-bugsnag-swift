workspace 'RudderBugsnag.xcworkspace'
use_frameworks!
inhibit_all_warnings!
platform :ios, '12.0'

def shared_pods
    pod 'RudderStack', :path => '~/Documents/Rudder/RudderStack-Cocoa/'
end

target 'SampleAppObjC' do
    project 'Examples/SampleAppObjC/SampleAppObjC.xcodeproj'
    shared_pods
    pod 'RudderBugsnag', :path => '.'
end

target 'SampleAppSwift' do
    project 'Examples/SampleAppSwift/SampleAppSwift.xcodeproj'
    shared_pods
    pod 'RudderBugsnag', :path => '.'
end

target 'RudderBugsnag' do
    project 'RudderBugsnag.xcodeproj'
    shared_pods
    pod 'Bugsnag', '6.16.4'
end
