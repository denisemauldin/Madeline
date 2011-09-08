module Madeline

  VERSION 		= "0.1.4"

  MADELINE_VERSION	= "2.0"

  MADELINE_ROOT		= File.expand_path(File.dirname(__FILE__))

  MADELINE_COMMAND	= "#{MADELINE_ROOT}/../ext/madeline/madeline2-linux-x86_64"


end

require 'madeline/interface'
