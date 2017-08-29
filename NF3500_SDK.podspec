Pod::Spec.new do |s|

  s.name          = "NF3500_SDK"
  s.version       = "1.0.0"
  s.summary       = "NF3500 SDK for iOS"
  s.homepage      = ""
  s.source        = '~/Documents/Projects/My Projects/NF3500_SDK'

  s.license       = "All rights reserved."

  s.author        = { "Michael Dorak" => "mjdorak5@gmail.com" }
 
  s.platform      = :ios, "10.3"
  s.module_name   = 'NF3500_SDK'
  
  s.requires_arc = true

  s.dependency "Alamofire"
  s.dependency "AEXML"

end
