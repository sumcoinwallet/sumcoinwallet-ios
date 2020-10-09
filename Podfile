# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
workspace 'Litewallet.xcworkspace'
project 'Litewallet.xcodeproj', 'Debug' => :debug,'Release' => :release
use_frameworks!
#Due to bug in firebase 
#https://github.com/firebase/firebase-ios-sdk/issues/6682
inhibit_all_warnings!
#####

#Shared Cocopods
def shared_pods
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  
  # add after v2.6.0 pod 'SwiftLint'
end

def shared_watchOS_pods
end

target 'Litewallet' do
  platform :ios, '13.0'
  shared_pods
  
  target 'LitewalletTests' do
    inherit! :search_paths
  end
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end



