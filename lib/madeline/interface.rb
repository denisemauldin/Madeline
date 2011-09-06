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
      begin
        log = `#{command} --outputprefix #{tempoutfile.path} --outputext .xml #{tempfile.path}`
        unless (log.match(/Pedigree output file is/)) then
	  raise Error, "Madeline failed to run.  Check Madeline path."
	end
        filename = "#{tempoutfile.path}.xml"
	if (!File.exists?(filename)) then
	  raise Error, "Output File doesn't exist."
        end
        f = File.new(filename,"r")
        return f.read
      rescue Exception
        raise Error, "Madeline failed to run. Tried #{@madeline}"
      ensure
        tempfile.close!
      end
      unless $?.exitstatus.zero?
        raise Error, result
      end

      yield(StringIO.new(result)) if block_given?
      result
    end

    private

    def serialize_options(options)
      options.map do |k, v|
        next if k == 'outputext'
        next if k == 'outputprefix'
        if (v == true || v == "true")
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
