require 'rake' 

PKG_FILES = "Where are my files?"

CURRENT_VERSION = ''

Gem::Specification.new do |s|
  s.name              = ""
  s.version           = 
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = ""
  s.homepage          = ""
  s.email             = ""
  s.authors           = [ "" ]
  s.has_rdoc          = false

  s.files             = "Where are my files?"

  s.add_dependency('any dependencies?')

  s.executables       = ""

  s.description       = <<desc
  A much more elequent and long description of 
  your project here. Tell me here why I should 
  download and use _your_ gem
desc
end
