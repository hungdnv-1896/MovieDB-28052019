# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MovieDB' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MovieDB

# Clean Architecture
    pod 'MGArchitecture', '0.4.0'
    pod 'MGAPIService', '0.5.0'
    pod 'MGLoadMore', '0.3.0'
    
    # Core
    pod 'ObjectMapper', '3.3'
    pod 'Reusable', '4.0.4'
    pod 'Then', '2.4'
    pod 'MJRefresh', '3.1'
    pod 'Validator', '3.0.2'
    
    # Rx
    pod 'NSObject+Rx', '4.4'
    pod 'RxDataSources', '3.1'
    
    # Core Data
    pod 'MagicalRecord', '2.3'
    
    #
    pod 'OrderedSet', '3.0'
    pod 'MBProgressHUD', '1.1'
    pod 'SDWebImage', '5.0'
    pod 'ActionSheetPicker-3.0', '2.3'

  target 'MovieDBTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '4.5'
  end

  target 'MovieDBUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if ['Validator', 'OrderedSet', 'Differentiator'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
