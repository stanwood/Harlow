Pod::Spec.new do |s|
  s.name             = 'Harlow'
  s.version          = '1.4'
  s.summary          = 'Harlow provide live view debugging'
  s.description      = <<-DESC
    Live debugger for:
        1. Analytics
        2. Crashes
        3. Logs
        4. Networking
        5. Errors
                       DESC

  s.homepage         = 'https://github.com/stanwood/Harlow'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'stanwood' => 'ios.frameworks@stanwood.io' }
  s.source           = { :git => 'https://github.com/stanwood/Harlow.git', :tag => s.version.to_s }
  
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = [
    'Harlow/Controller/**/*',
    'Harlow/Views/**/*',
    'Harlow/Modules/**/*',
    'Harlow/Model/**/*',
    'Harlow/Protocols/**/*',
    'Harlow/Extensions/**/*'
  ]
  
  s.resource_bundles = {
      'Harlow' => [
      'Harlow/Assets/*',
      'Harlow/Resources/*',
      'Harlow/Views/**/*.xib',
      'Harlow/Modules/**/*.xib'
      ]
  }

  s.dependency 'Pulsator'
  s.dependency 'SourceModel'
  s.dependency 'Toast-Swift', '~> 4.0.1'
end
