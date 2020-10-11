# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
workspace 'loafwallet.xcworkspace'
project 'loafwallet.xcodeproj', 'Debug' => :debug,'Release' => :release
use_frameworks!

### Workaround due to: https://github.com/firebase/firebase-ios-sdk/issues/6694
inhibit_all_warnings!
###

#Shared Cocopods
def shared_pods
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
end

def shared_watchOS_pods
end

target 'loafwallet' do
  platform :ios, '13.0'
  shared_pods
  
  target 'loafwalletTests' do
    inherit! :search_paths
  end
end

# Forces pods to target the same iOS version as the project
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end



