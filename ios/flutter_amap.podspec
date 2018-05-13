#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_amap'
  s.version          = '0.0.1'
  s.summary          = 'A Flutter plugin use amap.'
  s.description      = <<-DESC
A Flutter plugin use amap 高德地图flutter组件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'JZoom' => 'jzoom8112@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AMap3DMap'
  
  s.ios.deployment_target = '8.0'
end

