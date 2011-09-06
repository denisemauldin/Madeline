require 'rubygems'
require 'rake'
require 'echoe'
require 'rake/testtask'
require 'rake/rdoctask'

Echoe.new('madeline','0.1.1') do |p|
  p.description 		= "Interface to Madeline2"
  p.url				= "http://github.com/dmauldin/madeline"
  p.author			= "Denise Mauldin"
  p.email			= "denise.mauldin@gmail.com"
  p.ignore_pattern 		= ["tmp/*", "script/*"]
  p.executables			= PKG_FILES.grep(%r{\Aext\/.}).map { |ext|
           ext.gsub(%r{\Aext/}, '')
	   }
  p.files = PKG_FILES
  p.development_dependencies	= []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext}

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the madeline plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the madeline plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Madeline'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
