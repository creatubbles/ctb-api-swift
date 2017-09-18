platform :ios, '8.0'
use_frameworks!
inhibit_all_warnings!

def test_pods
    pod 'Quick', '~> 1.1.0'
    pod 'Nimble', '~> 7.0.0'
end

def shared_pods
    pod 'ObjectMapper', '~> 2.0'
    pod 'XCGLogger', '~> 4.0.0'
    pod 'RealmSwift',  '~> 2.10.1'
    pod 'KeychainAccess', '~> 3.0.1'
    pod 'SwiftLint'
end

target 'CreatubblesAPIClient' do
    shared_pods
end

target 'CreatubblesAPIClientUnitTests' do
    test_pods
end

target 'CreatubblesAPIClientIntegrationTests' do
    test_pods
end

target 'CreatubblesAPIClientDemo' do
    shared_pods
    pod 'CreatubblesAPIClient', :git => 'https://github.com/creatubbles/ctb-api-swift.git', :branch => 'feature/469_xcode_9'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

