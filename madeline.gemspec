# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "madeline"
  s.version = "0.1.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denise Mauldin"]
  s.date = "2012-06-25"
  s.description = "Interface to Madeline2"
  s.email = "denise.mauldin@gmail.com"
  s.extra_rdoc_files = ["README.md", "ext/madeline/madeline2-linux-x86_64-r99", "lib/madeline.rb", "lib/madeline/interface.rb"]
  s.files = ["README.md", "Rakefile", "ext/madeline/madeline2-linux-x86_64-r99", "lib/madeline.rb", "lib/madeline/interface.rb", "madeline.gemspec", "test/fixtures/madeline.yml", "test/fixtures/madeline.yml.old", "test/labels.txt", "test/madeline_test.rb", "test/pedigree.txt", "test/test_helper.rb", "Manifest"]
  s.homepage = "http://github.com/dmauldin/madeline"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Madeline", "--main", "README.md"]
  s.require_paths = ["lib", "ext"]
  s.rubyforge_project = "madeline"
  s.rubygems_version = "1.8.15"
  s.summary = "Interface to Madeline2"
  s.test_files = ["test/test_helper.rb", "test/madeline_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
