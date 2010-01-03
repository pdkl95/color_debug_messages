require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "color_debug_messages"
    gem.summary = %Q{Easy to read output on STDOUT}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "gem-color_debug_messages@thoughtnoise.net"
    gem.homepage = "http://github.com/pdkl95/color_debug_messages"
    gem.authors = ["Brent Sanders"]
    gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "color_debug_messages #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
