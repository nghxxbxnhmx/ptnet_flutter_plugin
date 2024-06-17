Pod::Spec.new do |s|
  s.name             = 'ptnet_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin.'
  s.description      = <<-DESC
                      A Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Nghĩa Thành Phan (Personal Team)' => 'tthanhnghia1411@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Runner/Classes/**/*'
  s.dependency       'Flutter'
  s.platform         = :ios, '9.0'
  s.swift_version    = '5.0'

  # Đường dẫn đến PTNetFramework.framework
  s.vendored_frameworks = 'Frameworks/PTNetFramework.framework'

  # Đường dẫn đến NetDiagnosis (package dependency)
  s.vendored_libraries = 'Frameworks/NetDiagnosis'

  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
  }
end