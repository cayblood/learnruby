require 'rake'

PKG_FILES = FileList[
  'lib/**/*.rb',
  'test/**/*.rb',
	'Rakefile',
	'Gemfile',
	'bin/check-links'
]

CURRENT_VERSION = '0.1.0'

Gem::Specification.new do |s|
  s.name              = "check-links"
  s.version           = CURRENT_VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "check-links is a link checker"
  s.homepage          = "http://not-on-github-yet.com"
  s.email             = "joe@edgecase.com"
  s.authors           = [ "Jim Weirich", "Joe O'Brien" ]
  s.has_rdoc          = false

  s.files             = PKG_FILES

  s.add_dependency('nokogiri')

  s.executables       = %w( check-links )

  s.description       = <<desc
  A much more elequent and long description of the link 
  checker and it's various features. Tell me here why I 
  should download and use _your_ gem
desc
end
