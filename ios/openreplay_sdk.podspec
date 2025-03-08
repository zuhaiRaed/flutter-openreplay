#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint openreplay_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'openreplay_sdk'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for OpenReplay SDK'
  s.description      = <<-DESC
A Flutter plugin for integrating OpenReplay SDK in iOS applications.
                       DESC
  s.homepage         = 'https://openreplay.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'OpenReplay' => 'support@openreplay.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.swift_version = '5.0'
  s.dependency 'Openreplay', '~> 1.0.13'  # Ensure this matches the actual pod name



  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'openreplay_sdk_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end
