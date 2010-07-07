Gem::Specification.new do |s|
  s.name        = "rich_text"
  s.version     = '0.0.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Stewart"]
  s.email       = ["james@ketlai.co.uk"]
  s.summary     = "Rich text editor with image upload"
  s.description = "Rails engine to get you up and running with the tinymce rich text editor and some utilities to pull in video and images."
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rails"
  s.add_development_dependency "paperclip"
 
  s.files        = Dir.glob("lib/**/*") + Dir.glob("app/**/*") + ["README"]
  s.require_path = 'lib'
end