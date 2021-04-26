#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cookie_manager.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cookie_manager'
  s.version          = '0.0.1'
  s.summary          = 'A flutter plugin library of Webview cookie manager.'
  s.description      = <<-DESC
  A flutter plugin library of Webview cookie manager.
                       DESC
  s.homepage         = 'https://github.com/iliYF/webview_cookie_manager'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'iliYF' => 'yeelik.fung@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
