Pod::Spec.new do |s|
  s.name             = 'TMKeyboardManager'
  s.version          = '1.0.1'
  s.summary          = 'Just a little syntax sugar for your Keyboard and UITextFIeld experience'
  s.homepage         = 'https://github.com/Rayllienstery/TMKeyboardManager'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { 'Konstantin Kolosov' => 'rayleefx@protonmail.com' }
  s.source           = { :git => 'https://github.com/Rayllienstery/TMKeyboardManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '14.0'
  s.swift_version = '5.5'
  s.source_files = 'Sources/TMKeyboardManager/**/*'
end