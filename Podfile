platform :ios, "9.0"
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'


target "ProkrutObjc" do
    pod 'Parse', '~> 1.12'
  pod 'CorePlot', '2.0'
  pod 'InputValidators', '~> 1.0'
  pod 'MBProgressHUD', '~> 1.0'
  pod 'Alamofire'
  pod 'EasyMapping'
  pod 'RestKit'
  pod 'ObjectMapper'
  pod 'Nimbus'
  pod 'GoogleAnalytics'

  pod 'Typhoon'
  pod 'RamblerTyphoonUtils/AssemblyCollector'
  pod 'ViperMcFlurry'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'Nimbus'
      target.build_configurations.each do |config|
        config.build_settings['ENABLE_STRICT_OBJC_MSGSEND'] = 'NO'
      end
    end
  end
end