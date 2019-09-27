Pod::Spec.new do |s|
  s.name             = 'StanwoodDebugger'
  s.version          = '1.2'
  s.summary          = 'Stanwood debugger provide live view debugging'
  s.description      = <<-DESC
    Live debugger for:
        1. Analytics
        2. Crashes
        3. Logs
        4. Networking
        5. Errors
                       DESC

  s.homepage         = 'https://github.com/stanwood/Stanwood_Debugger_iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'stanwood' => 'ios.frameworks@stanwood.io' }
  s.source           = { :git => 'https://github.com/stanwood/Stanwood_Debugger_iOS.git', :tag => s.version.to_s }
  
  s.swift_version = '5.0'
  s.ios.deployment_target = '10.0'

  s.source_files = [
    'StanwoodDebugger/Controller/**/*',
    'StanwoodDebugger/Views/**/*',
    'StanwoodDebugger/Modules/**/*',
    'StanwoodDebugger/Model/**/*',
    'StanwoodDebugger/Protocols/**/*',
    'StanwoodDebugger/Extensions/**/*'
  ]
  
  s.resource_bundles = {
      'StanwoodDebugger' => [
      'StanwoodDebugger/Assets/*',
      'StanwoodDebugger/Resources/*',
      'StanwoodDebugger/Views/**/*.xib',
      'StanwoodDebugger/Modules/**/*.xib'
      ]
  }

  s.dependency 'Pulsator'
  s.dependency 'StanwoodCore'
  s.dependency 'SourceModel'
  s.dependency 'Toast-Swift', '~> 4.0.1'
end
