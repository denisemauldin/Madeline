require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('madeline','0.1.0') do |p|
  p.description 		= "Run Madeline2 on pedigree hash"
  p.url				= "http://github.com/dmauldin/madeline"
  p.author			= "Denise Mauldin"
  p.email			= "denise.mauldin@gmail.com"
  p.ignore_pattern 		= ["tmp/*", "script/*"]
  p.development_dependencies	= []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext}

