platform :ios, "9.0"

source 'git@gitlab.rambler.ru:cocoapods/cocoapods.git'
source 'https://github.com/CocoaPods/Specs.git'

plugin 'cocoapods-keys', {
    :project => "ProkrutObjc",
    :keys => [
    "ParseApplicationId",
    "ParseClientKey"
    ]}

pod 'Parse', '~> 1.12'
pod 'Nimbus/Models', :git => 'https://github.com/rambler-ios/nimbus'
pod 'CorePlot', '2.0'
pod 'InputValidators', '~> 1.0'
pod 'MBProgressHUD', '~> 1.0'

pod 'Typhoon'
pod 'RamblerTyphoonUtils/AssemblyCollector'
pod 'ViperMcFlurry'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'Nimbus'
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = 'NO'
      end
    end
  end
end