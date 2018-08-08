#
#  Be sure to run `pod spec lint LCFCategory.podspec.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name                   = "LCFCategory"
  s.version                = "1.0.0"
  s.summary                = "category"
  s.ios.deployment_target  = '8.0'
  s.homepage               = "https://github.com/lixianshen/LCFCategory"
  s.license                = { :type => "MIT", :file => "LICENSE" }
  s.author                 =   { "WLee" => "810646506@qq.com" }
  s.social_media_url       = "www.lichengfublog.com"
  s.source                 = { :git => "https://github.com/lixianshen/LCFCategory", :tag => s.version }
  s.source_files           = "LCFCategory/*"
  s.public_header_files    = "LCFCategory/**/*.h"
  s.requires_arc           = true
end
