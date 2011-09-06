= Madeline

Rails gem for running madeline on a pedigree hash

h2. Installation

<pre>
sudo gem install madeline
</pre>

h2. Usage

The @Madeline::Interface@ has a single method, @draw@, which can be passed a string or an open @IO@ object, and returns the Madeline XML. The result is returned as a string, or, if a block is passed, yields as an @IO@ object for streaming writes.

<pre>
require 'rubygems'
require 'madeline'
Madeline::Interface.new.draw(File.open('pedigree.txt', 'r'))
</pre>

When creating a @Madeline::Interface@, you can pass [any options that the madeline2 program accepts](http://eyegene.ophthy.med.umich.edu/madeline/documentation.php) to the interface and they'll be forwarded. For example, to create an embedded result:

<pre>
artist = Madeline::Interface.new(:embedded => true)
artist.draw(File.open('pedigree.txt', 'r'))

</pre>

The default values of all the madeline2 flags are identical to the command-line version.

A @Madeline::Error@ exception will be raised if draw fails for any reason.

h2. Madeline Location

The @Madeline::Interface@ initializer can take a @madeline@ option, overriding the location of the madeline2 program.

<pre>
artist = Madeline::Interface.new(
  :madeline     => '/usr/local/bin/madeline2'
)
</pre>

