#
# Be sure to run `pod lib lint SMDiagramViewSwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

#
# Be sure to run `pod lib lint SMDiagramViewSwift.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|

    #root
        s.name      = 'SMDiagramViewSwift'
        s.version   = '1.0.0'
        s.summary   = 'SMDiagramViewSwift descriptions'
        s.license   = { :type => 'Apache', :file => 'LICENSE.txt' }

        s.homepage  = 'https://github.com/VRGsoftUA/SMDiagramView'
        s.authors   = {'pawlo2102' => 'pawlo2102@gmail.com'}
        s.source    = { :git => 'https://github.com/VRGsoftUA/SMDiagramView.git', :branch => 'master', :tag => '1.0.0' }

    #platform
        s.platform = :ios
        s.ios.deployment_target = '10.0'
        s.swift_version = '5.0'

    #build settings
        s.requires_arc = true

    #file patterns
        s.source_files = 'SMDiagramViewSwift/*.{swift}'
end
