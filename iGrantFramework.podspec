#
# Be sure to run `pod lib lint iGrantFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'iGrantFramework'
  s.version          = '0.1.0'
  s.summary          = 'Framework to integrate iGrant.io Services to your app.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'You can enable iGrant.io services by adding this framework to your app. To know more about iGrant.io visit https://igrant.io/'

  s.homepage         = 'https://github.com/rebink/iGrantFramework'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = 'Mohamed Rebin K'
  s.source           = { :git => 'https://github.com/rebink/iGrantFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

    s.source_files = 'iGrantFramework/Classes/**/*'
    s.swift_version = '4.2'
    s.resource_bundles = {
    'iGrantFramework' => ['iGrantFramework/Assets/**/*.png'],
    'PopView' => ['iGrantFramework/Classes/iGrantFiles/Organisation/PopOverView.xib']
    }
#  s.resources = 'iGrantFramework/Classes/iGrantFiles/iGrantAssets.xcassets/checked.imageset/checked@2x.png'

  # s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit' , 'SafariServices'
s.dependency 'AFNetworking'
s.dependency 'Kingfisher'
s.dependency 'Alamofire'
s.dependency 'SwiftyJSON'
s.dependency 'MBProgressHUD'
s.dependency 'SkyFloatingLabelTextField'
s.dependency 'IQKeyboardManagerSwift'
s.dependency "ExpandableLabel"
s.dependency "Popover"
s.dependency 'Closures'
s.dependency 'Localize-Swift'
s.dependency 'Toast-Swift'
s.dependency 'CountryPickerSwift'



end
