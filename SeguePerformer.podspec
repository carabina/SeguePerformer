#
# Be sure to run `pod lib lint SeguePerformer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SeguePerformer'
  s.version          = '0.1.0'
  s.summary          = 'A Swift class for initiating segues using closures for view controller preparation.'

  s.description      = <<-DESC
A downside of UIViewController.performSegue(withIdentifier:sender:) is that
configuration of the presented view controller must occur separately in
UIViewController.prepare(for:sender:) instead of locally at the call site. This
can become particularly awkward in the context of multiple segues. SeguePerformer
improves upon this by providing
peformSegue(withIdentifier:sender:preparationHandler:), which provides an
opportunity to configure the presented view controller via a trailing closure.
                       DESC

  s.homepage         = 'https://github.com/milpitas/SeguePerformer'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'milpitas' => 'drew.olbrich@gmail.com' }
  s.source           = { :git => 'https://github.com/milpitas/SeguePerformer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/drewolbrich'

  s.ios.deployment_target = '11.0'

  s.source_files = 'SeguePerformer'
  
  # s.resource_bundles = {
  #   'Whatever' => ['SeguePerformer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.swift_version = '4.2'
end
