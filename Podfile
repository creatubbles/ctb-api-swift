platform :ios, '9.0'
use_frameworks!

target 'CreatubblesAPIClient' do

pod 'p2.OAuth2', :git => 'https://github.com/creatubbles/OAuth2.git', :branch => 'feature/Swift_Update'
pod 'Alamofire', '~> 4.0'
pod 'ObjectMapper', '~> 2.0'
pod 'XCGLogger', '3.2'
pod 'RealmSwift', '2.0'

end

target 'CreatubblesAPIClientTests' do

pod 'Quick', '0.9.1'
pod 'Nimble', '3.2.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

