platform :ios, "9.0"
use_frameworks!

source 'git@gitlab.rambler.ru:cocoapods/cocoapods.git'
source 'https://github.com/CocoaPods/Specs.git'

plugin 'cocoapods-keys', {
    :project => "ProkrutObjc",
    :keys => [
    "ParseApplicationId",
    "ParseClientKey"
    ]}

pod 'Parse', '~> 1.12'
pod 'Nimbus/Models', :git => 'git@gitlab.rambler.ru:cocoapods/nimbus.git', :tag => '1.2.2'
pod 'CorePlot', '2.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'Nimbus'
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = 'NO'
      end
    end
  end
end