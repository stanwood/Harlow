Pod::Spec.new do |s|
  s.name             = 'StanwoodDebugger'
  s.version          = '0.0.1'
  s.summary          = 'Stanwood debugger provide live view debugging'
  s.description      = <<-DESC
    Live debugger for:
        1. Analytics
        2. UITesting views and keys
        3. General logger
        4. Networking
        5. Errors
                       DESC

  s.homepage         = 'https://github.com/stanwood/Stanwood_Debugger_iOS'
  s.license          = { :type => 'Private', :file => 'LICENSE' }
  s.author           = { 'Tal Zion' => 'talezion@gmail.com' }
  s.source           = { :git => 'git@github.com:stanwood/Stanwood_Debugger_iOS.git', :tag => s.version.to_s }
  
  s.swift_version = '4.0'
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
      'StanwoodDebugger/Views/**/*.xib',
      'StanwoodDebugger/Modules/**/*.xib'
      ]
      
  }

  s.dependency 'Pulsator'
  s.dependency 'StanwoodCore'
end
