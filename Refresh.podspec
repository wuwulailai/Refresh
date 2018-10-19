#
#  Be sure to run `pod spec lint Refresh.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "Refresh"
  s.version      = "0.0.1"
  s.summary      = "刷新数据和网络异常"

  s.description  = <<-DESC
                   DESC

  s.homepage     = "https://github.com/wuwulailai/Refresh"
  
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "wuwulailai" => "908715560@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/wuwulailai/Refresh.git", :tag => "#{s.version}" }

  s.source_files  = "Refresh/**/*.swift"
  s.resource  = "Refresh/Resource/*"
  s.dependency "SnapKit"

end
