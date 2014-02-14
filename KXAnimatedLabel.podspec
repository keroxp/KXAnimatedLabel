Pod::Spec.new do |s|


  s.name         = "KXAnimatedLabel"
  s.version      = "0.0.1"
  s.summary      = "A name based shared data space."

  s.description  = <<-DESC
                    A name based shared data space.
                   DESC

  s.homepage     = "https://github.com/keroxp/KXAnimatedLabel"
  s.license      = 'MIT'

  s.author             = { "Yusuke Sakurai" => "kerokerokerop@gmail.com" }
  s.social_media_url = "http://twitter.com/keroxp"

  s.platform     = :ios, '6.0'

  s.source       = { :git => "https://github.com/keroxp/KXAnimatedLabel.git", :tag => "0.0.1" }

  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'

  s.public_header_files = 'Classes/**/*.h'

end
