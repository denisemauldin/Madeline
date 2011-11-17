require 'stringio'
require 'tempfile'

module Madeline

  class Error < StandardError; end

  class Interface

    DEFAULT_OPTIONS = {}

    def initialize(options={})
      @madeline = options.delete(:madeline) || MADELINE_COMMAND
      @options = serialize_options(DEFAULT_OPTIONS.merge(options))
    end

    def draw(io)
      tempfile = Tempfile.new('madeline')
      if io.respond_to? :read
        while buffer = io.read(4096) do
          tempfile.write(buffer)
        end
      else 
        tempfile.write(io.to_s)
      end
      tempfile.flush
      tempoutfile = Tempfile.new('madeline_output')
      if !File.exists?(tempfile.path)
        raise Error, "Failed to create madeline input file #{tempfile.path}"
      end
      begin
        log = `#{command} --outputprefix #{tempoutfile.path} --outputext .xml #{tempfile.path} 2>&1`
        unless (log.match(/Pedigree output file is/)) then
	  raise Error, "Madeline failed to run or had a segmentation fault.  #{command} --outputprefix #{tempoutfile.path} --outputext .xml #{tempfile.path}"
	end
        filename = "#{tempoutfile.path}.xml"
	if (!File.exists?(filename)) then
	  raise Error, "Output File doesn't exist. #{filename}   command was : #{command} --outputprefix #{tempoutfile.path} --outputext .xml #{tempfile.path}"
        end
      rescue 
	if log.nil? then
          raise Error, "Madeline failed to run. Tried #{@madeline}.  #{$!}"
	else
	  raise Error, "Madeline had an error: #{log}  Tried #{@madeline}.\n #{$!}\n"
	end
      ensure
        tempfile.close!
      end
      unless $?.exitstatus.zero?
        raise Error, log 
      end
      warnings = Array.new
      lines = log.split("\n")
      lines.each do |line|
	line.gsub!("\e[0m","") # remove the end color code from madeline2
        warnings.push(line.match(/Warning:.*/)[0]) if line.match(/Warning:/)
      end
      warn = warnings.join("; ")
      if block_given? then
        f = File.new(filename)
	contents = f.read
	File.delete(filename)
        yield(StringIO.new(contents), warn)
      end
      return filename, warn
    end

    private

    def serialize_options(options)
      options.map do |k, v|
        next if k == 'outputext'
        next if k == 'outputprefix'
	if (k.to_s == 'L')
	  if v.is_a?(Array)
	    vals = v.join(" ")
	    ["-L \"#{vals}\""]
          else 
  	    ["-L \"#{v}\""]
	  end 
        elsif (v == true || v == "true")
          ["--#{k}"]
        elsif (v.is_a?(Array))
          v.map {|v2| ["--#{k}", v2.to_s]}
        else
          ["--#{k}", v.to_s]
        end
      end.flatten
    end

    def command
      [@madeline, @options].flatten.join(' ')
    end

  end

end
