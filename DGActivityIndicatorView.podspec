#
#  Be sure to run `pod spec lint DGActivityIndicatorView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "DGActivityIndicatorView"
  s.version      = "2.2.0"
  s.authors      = { "Danil Gontovnik" => "danil@gontovnik.com" }
  s.homepage     = "https://github.com/gontovnik/DGActivityIndicatorView"
  s.summary      = "DGActivityIndicatorView is a great way to make loading spinners in your application look nicer."
  s.source       = { :git => "https://github.com/gontovnik/DGActivityIndicatorView.git",
                     :tag => '2.2.0' }
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform = :ios, '7.0'
  s.source_files = "DGActivityIndicatorView/**/*.{h,m}"

  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.ios.frameworks = ['UIKit', 'Foundation']
end
