platform :ios, '13.0'

target 'Flash Chat' do

  # Pods for Flash Chat
    pod 'CLTypingLabel'
    pod 'Firebase/Auth'
    pod 'Firebase/Firestore'
    pod 'IQKeyboardManagerSwift'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
