Pod::Spec.new do |s|

  s.name         = "ACRippleView"
  s.version      = "1.0.0"
  s.summary      = "A great `Ripple` Effect View for iOS."

  s.description  = <<-DESC
                   A great `Ripple` Effect View for iOS.
                   DESC

  s.homepage     = "https://github.com/azurechen/ACRippleView"
  s.license      = "MIT"
  s.author       = { "azurechen" => "azure517981@gmail.com" }
  s.source       = { :git => "https://github.com/azurechen/ACRippleView.git", :tag => "v1.0.0" }
  s.platforms = { :ios => "8.0" }

  s.source_files  = "Sources/**/*.swift"

end
