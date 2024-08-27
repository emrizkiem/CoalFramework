Pod::Spec.new do |s|
  s.name             = 'CoalFramework'
  s.version          = '0.0.1'
  s.summary          = 'A Core App Library'
  s.homepage         = 'https://github.com/emrizkiem/CoalFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ArifRach' => 'arifrach31@gmail.com', 'M. Rizki Maulana' => 'devemrizkiem@gmail.com' }
  s.source           = { :git => 'https://github.com/emrizkiem/CoalFramework.git', :tag => s.version.to_s }
  s.platform         = :ios, "13.0"
  s.source_files     = "CoalFramework/**/*.swift"
  s.resources        = "CoalFramework/**/*.xcassets"
  s.swift_versions   = ['5']
end
