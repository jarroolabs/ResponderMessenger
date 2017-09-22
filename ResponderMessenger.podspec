#
# Be sure to run `pod lib lint ResponderMessenger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ResponderMessenger'
  s.version          = '0.1.0'
  s.summary          = 'Plugs into the UIResponder chain to provide a Swift-first, loosely-coupled, protocol-oriented, inter-component messaging pattern.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  ResponderMessenger plugs into the UIResponder chain to provide a loosely-coupled, protocol-oriented, inter-component messaging pattern. 
  The pattern is not opinionated on how you should employ it, however, you may want to use to notify the view in MVVM; or notify the controller 
  from a table/collection view cell, without needing to resort to the usual delegate or notification closure pattern.

  ResponderMessenger can also be used to bubble messages so they can be handled by multiple receivers.
                       DESC

  s.homepage         = 'https://github.com/jarrroo/ResponderMessenger'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alex Manarpies' => 'alex@jarroo.com' }
  s.source           = { :git => 'https://github.com/jarrroo/ResponderMessenger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'ResponderMessenger/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ResponderMessenger' => ['ResponderMessenger/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
