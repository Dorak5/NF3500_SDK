Pod::Spec.new do |s|

  s.name          = "NF3500_SDK"

  s.version       = "1.0.1"

  s.summary       = "NF3500 SDK for iOS"

  s.license       = "All rights reserved."

  s.homepage      = "https://github.com/Dorak5/NF3500_SDK"

  s.author        = { "Michael Dorak" => "mjdorak5@gmail.com" }

  s.platform      = :ios, "11.0"

  s.source       = { :git => 'https://github.com/Dorak5/NF3500_SDK.git', :tag => s.version }

  s.source_files = 'NF3500_SDK/**/*.{h,m,swift}'

  s.module_name   = 'NF3500_SDK'
  
  s.requires_arc = true

  s.dependency "Alamofire"
  s.dependency "AEXML"

end
