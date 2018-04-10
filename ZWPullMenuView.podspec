Pod::Spec.new do |s|

  s.name    = 'ZWPullMenuView'
  s.version = '0.0.2'
  s.summary = '下拉选择视图、支持微信、支付宝等样式。自动计算最优显示位置、动画效果。'
  s.homepage  = 'https://github.com/wangziwu/ZWPullMenuView'
  s.license = 'MIT'
  s.authors = {'wangziwu' =>  'wang_ziwu@126.com'}
  s.platform  = :ios,'8.0'
  s.ios.deployment_target = '8.0'
  s.source  = {:git => 'https://github.com/wangziwu/ZWPullMenuView.git',:tag => s.version}
  s.source_files  = 'ZWPullMenuView/*.{h,m}'
  s.resources     = 'ZWPullMenuView/*.{png,xib,nib,bundle}'
  s.requires_arc  = true
end
