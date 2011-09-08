Madeline
========

Rails gem for running madeline on a pedigree hash

Installation
------------

<pre>
sudo gem install madeline
</pre>

Usage
-----

The *Madeline::Interface* has a single method, `draw`, which can be passed a string or an open *IO* object, and returns the Madeline XML. The draw method returns a filename and warnings, or, if a block is passed, yields the file contents and warnings.

<pre>
require 'rubygems'
require 'madeline'
pedigree_filename, warnings = Madeline::Interface.new.draw(File.open('pedigree.txt', 'r'))
</pre>

<pre>
require 'rubygems'
require 'madeline'
pedigree, warnings = Madeline::Interface.new.draw(File.open('pedigree.txt','r')) { |filehandle, warnings|
  puts "warnings #{warnings}"
  pedigree = filehandle.read
}
</pre>

When creating a *Madeline::Interface*, you can pass [any options that the madeline2 program accepts](http://eyegene.ophthy.med.umich.edu/madeline/documentation.php) to the interface and they'll be forwarded. For example, to create an embedded result:

<pre>
artist = Madeline::Interface.new(:embedded => true)
pedigree_filename, warnings = artist.draw(File.open('pedigree.txt', 'r'))
</pre>

The default values of all the madeline2 flags are identical to the command-line version.

A *Madeline::Error* exception will be raised if draw fails for any reason.

Madeline Location
-----------------

The *Madeline::Interface* initializer can take a `madeline` option, overriding the location of the madeline2 program.

<pre>
artist = Madeline::Interface.new(
  :madeline     => '/usr/local/bin/madeline2'
)
</pre>

