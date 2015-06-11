Pod::Spec.new do |s|
	s.name = 'SwiftHelpers'
	s.version = '1.0.0'
	s.license = 'MIT'
	s.summary = 'A collection of Swift extensions'
	s.homepage = 'https://github.com/dmiotti/SwiftHelpers'
	s.social_media_url = 'https://twitter.com/davidmiotti'
	s.authors = { 'David Miotti' => 'david.miotti@gmail.com' }
	s.source = { :git => 'https://github.com/dmiotti/SwiftHelpers.git', :tag => s.version }

	s.ios.deployment_target = '7.1'
	s.osx.deployment_target = '10.10'

	s.source_files = 'SwiftHelpers/*.swift'

	s.requires_arc = true
end
