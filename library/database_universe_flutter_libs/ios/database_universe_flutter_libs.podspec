Pod::Spec.new do |s|
  s.name             = 'database_universe_flutter_libs'
  s.version          = '1.0.0'
  s.summary          = 'Flutter binaries for the DatabaseUniverse Database. Needs to be included for Flutter apps.'
  s.homepage         = 'https://database_universe.dev'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DatabaseUniverse' => 'hello@database_universe.dev' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.swift_version = '5.3'
  s.vendored_frameworks = 'database_universe.xcframework'
end
