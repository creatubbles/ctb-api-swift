platform :ios, '8.0'
use_frameworks!

def test_pods
    pod 'Quick', '~> 0.10.0'
    pod 'Nimble', '~> 5.0.0'
end

target 'CreatubblesAPIClient' do

pod 'ObjectMapper', '~> 2.0'
pod 'XCGLogger', '~> 4.0.0'
pod 'RealmSwift', '2.0.3'
pod 'KeychainAccess', '~> 3.0.1'

end

target 'CreatubblesAPIClientUnitTests' do
    test_pods
end

target 'CreatubblesAPIClientIntegrationTests' do
    test_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

