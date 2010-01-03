# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{color_debug_messages}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brent Sanders"]
  s.date = %q{2010-01-02}
  s.description = %q{Module to add colorful debug messages to a class.}
  s.email = %q{gem-color_debug_messages@thoughtnoise.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "color_debug_messages.gemspec",
     "lib/color_debug_messages.rb",
     "test/helper.rb",
     "test/test_color_debug_messages.rb"
  ]
  s.homepage = %q{http://github.com/pdkl95/color_debug_messages}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Easy to read output on STDOUT}
  s.test_files = [
    "test/helper.rb",
     "test/test_color_debug_messages.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<term-ansicolor>, [">= 1.0.4"])
    else
      s.add_dependency(%q<term-ansicolor>, [">= 1.0.4"])
    end
  else
    s.add_dependency(%q<term-ansicolor>, [">= 1.0.4"])
  end
end
