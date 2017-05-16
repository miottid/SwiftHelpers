Pod::Spec.new do |s|
	s.name = 'SwiftHelpers'
	s.version = '5.0.2'
	s.license = 'MIT'
	s.summary = 'A collection of Swift extensions'
	s.homepage = 'git@github.com:dmiotti/SwiftHelpers.git'
	s.social_media_url = 'https://twitter.com/davidmiotti'
	s.authors = { 'David Miotti' => 'david.miotti@gmail.com' }
	s.source = { :git => 'git@github.com:dmiotti/SwiftHelpers.git', :tag => 'v5.0.2' }

	s.ios.deployment_target = '8.0'
	s.osx.deployment_target = '10.10'

	s.source_files = 'SwiftHelpers/**/*.swift'

	s.requires_arc = true
    s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

    s.subspec 'Core' do |sp|
        sp.source_files = 'SwiftHelpers/Core', 'SwiftHelpers/SwiftHelpers.h'
    end

    s.subspec 'CoreData' do |sp|
        sp.source_files = 'SwiftHelpers/CoreData', 'SwiftHelpers/SwiftHelpers.h'
    end

    s.subspec 'DateTime' do |sp|
        sp.source_files = 'SwiftHelpers/Date-Time', 'SwiftHelpers/SwiftHelpers.h'
    end

    s.subspec 'UI' do |sp|
        sp.source_files = 'SwiftHelpers/UI', 'SwiftHelpers/SwiftHelpers.h'
    end

    s.subspec 'Misc' do |sp|
        sp.source_files = 'SwiftHelpers/Misc', 'SwiftHelpers/SwiftHelpers.h'
    end

    s.subspec 'Basic' do |sp|
        sp.source_files = 'SwiftHelpers/Misc/SHLocalizationHelper.swift', 'SwiftHelpers/UI/SHIBInspectableExtension.swift', 'SwiftHelpers/SwiftHelpers.h'
    end
end
