#
# Be sure to run `pod lib lint HCYFrameWork.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'HCYFrameWork'
    s.version          = '0.1.13'
    s.summary          = 'A short description of HCYFrameWork.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
    
    s.homepage         = 'https://github.com/tanxianj/HCYFrameWork'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'tanxianj' => 'xianjing.tan@techstudio.com.sg' }
    s.source           = { :git => 'https://github.com/tanxianj/HCYFrameWork.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '12.0'
    
    s.source_files = 'HCYFrameWork/Classes/**/*'
    
    
    #    s.subspec 'Common' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/Common/*.swift'
    #    end
    #    s.subspec 'Custom' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/Custom/*.swift'
    #        ss.dependency = 'HCYFrameWork/Classes/TSSBase'
    #        ss.dependency = 'HCYFrameWork/Classes/Extension'
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #
    #    s.subspec 'Extension' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/Extension/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #        ss.dependency = "HCYFrameWork/Classes/Custom"
    #    end
    #    s.subspec 'GCD' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/GCD/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Extension"
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #    s.subspec 'RxOperators' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/RxOperators/*.swift'
    #    end
    #    s.subspec 'TSSDefaultView' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSDefaultView/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Extension"
    #    end
    #    s.subspec 'TSSLoading' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSLoading/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Extension"
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #    s.subspec 'TSSNetworkingManager' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSNetworkingManager/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #    s.subspec 'TSSNotiFication' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSNotiFication/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #    s.subspec 'TSSPopUp' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSPopUp/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Extension"
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #    s.subspec 'TSSSegmented' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSSegmented/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #    end
    #    s.subspec 'TSSBase' do |ss|
    #        ss.source_files = 'HCYFrameWork/Classes/TSSBase/*.swift'
    #        ss.dependency = "HCYFrameWork/Classes/Common"
    #        ss.dependency = "HCYFrameWork/Classes/Custom"
    #    end
    
    
    # s.resource_bundles = {
    #   'HCYFrameWork' => ['HCYFrameWork/Assets/*.png']
    # }
    s.swift_version = '5.0'
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'SnapKit' ,'~> 5.0.0'
    s.dependency 'SVGKit'  #  SVGLength.m 232 line if( [platform hasPrefix:@"x86_64"] || [platform hasPrefix:@"arm64"])
    s.dependency 'RxSwift','~> 5.0'
    s.dependency 'RxCocoa','~> 5.0'
    s.dependency 'RxDataSources'
    s.dependency 'Alamofire'
    #    s.dependency 'RxAlamofire'
    #    s.dependency 'AlamofireObjectMapper', '~> 5.2.1'
    s.dependency 'MJRefresh'
    s.dependency 'Kingfisher'
    s.dependency 'SVProgressHUD'
    s.dependency 'IQKeyboardManagerSwift'
    s.dependency 'FLEX',:configurations => ['Debug'] #为Debug 模式引入
end
