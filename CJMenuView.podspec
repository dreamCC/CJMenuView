
Pod::Spec.new do |s|

  s.name         = "CJMenuView"
  s.version      = "1.0.0"
  s.summary      = "Selection tool used in the pop-up menu."
  s.description  = "Commonly used menu select control, project development, such as taobao, WeChat app."
  s.homepage     = "https://github.com/dreamCC/CJMenuView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "dreamCC" => "568644031@qq.com" }
  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dreamCC/CJMenuView.git", :tag => s.version }
  s.source_files  = "CJMenuView"
  s.requires_arc = true 
end
