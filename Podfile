# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'HealthCareLocatorSDK' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for HealthCareLocatorSDK
  pod 'Apollo', '~> 0.36.0'
  pod 'RxSwiftExt', '~> 5'
  
  target 'HealthCareLocatorSDKTests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
