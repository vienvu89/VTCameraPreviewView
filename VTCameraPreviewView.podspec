#
# Be sure to run `pod lib lint VTCameraPreviewView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VTCameraPreviewView'
  s.version          = '0.1.0'
  s.summary          = 'A subclass of UIView. Allow you preview camera to view.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    A subclass of UIView. Allow you preview camera to view. This is very simple to use. Just drag and choose you camera. It done!
                       DESC

  s.homepage         = 'https://github.com/vienvu89/VTCameraPreviewView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Vien Vu' => 'lamvienbk@gmail.com' }
  s.source           = { :git => 'https://github.com/vienvu89/VTCameraPreviewView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/vienvu89'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VTCameraPreviewView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VTCameraPreviewView' => ['VTCameraPreviewView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
