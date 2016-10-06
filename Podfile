platform :ios, '9.0'
use_frameworks!

target 'CreatubblesAPIClient' do

pod 'p2.OAuth2', :git => 'https://github.com/p2/OAuth2', :branch => 'develop', :submodules => true
pod 'Alamofire', '~> 4.0'
pod 'ObjectMapper', '~> 2.0'
pod 'XCGLogger', '~> 4.0.0'
pod 'RealmSwift', '2.0'

end

target 'CreatubblesAPIClientTests' do

pod 'Quick', '~> 0.10.0'
pod 'Nimble', '~> 5.0.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

