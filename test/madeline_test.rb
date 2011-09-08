require 'test/unit'
require 'stringio'
require File.dirname(__FILE__) + '/test_helper'
require 'madeline'

class MadelineTest < Test::Unit::TestCase
  fixtures :madeline

  def test_init
    assert_nothing_raised do 
      madeline = Madeline::Interface.new()
    end 
  end

  def test_construction
    artist = Madeline::Interface.new()
    pedigree_file, warnings = artist.draw(File.open('test/pedigree.txt','r'))
    pedigree = File.read(pedigree_file)
    assert_equal(@@fixtures["pedigree"], pedigree)
  end

  def test_madeline_location
    artist = Madeline::Interface.new(:madeline => '/u5/tools/bin/madeline2')
    pedigree_file, warnings = artist.draw(File.open('test/pedigree.txt','r'))
    pedigree = File.read(pedigree_file) 
    assert_equal(@@fixtures["pedigree"], pedigree)
  end
    
  def test_bad_madeline_location
    artist = Madeline::Interface.new(:madeline => 'jkfldsjkklfa')
    assert_raises Madeline::Error do
      artist.draw(File.open('test/pedigree.txt','r'))
    end
  end

  def test_arial
    artist = Madeline::Interface.new(:font => "Arial")
    pedigree_file, warnings = artist.draw(File.open('test/pedigree.txt','r'))
    pedigree = File.read(pedigree_file)
    assert_equal(@@fixtures["arial_out"], pedigree)
  end 

  def test_embedded
    artist = Madeline::Interface.new(:embedded => true)
    pedigree_file, warnings = artist.draw(File.open('test/pedigree.txt','r'))
    pedigree = File.read(pedigree_file)
    assert_equal(@@fixtures["embedded_out"], pedigree)
  end

  def test_bad_file_location
    artist = Madeline::Interface.new()
    assert_raises(Errno::ENOENT,"No such file or directory") do
      pedigree, warnings = artist.draw(File.open('test/blah.txt','r'))
    end
  end

  def test_labels
    artist = Madeline::Interface.new(:L => 'CM')
    pedigree_file, warnings = artist.draw(File.open('test/labels.txt','r'))
    pedigree = File.read(pedigree_file)
    assert_equal(@@fixtures["single_label_out"], pedigree)
  end

  def test_multiple_labels
    artist = Madeline::Interface.new(:L => ["CM","TTLD"])
    pedigree_file, warnings = artist.draw(File.open('test/labels.txt','r'))
    pedigree = File.read(pedigree_file)
    assert_equal(@@fixtures["label_out"], pedigree)
  end

  def test_block
    artist = Madeline::Interface.new(:L => ["CM","TTLD"])
    file = File.open('test/labels.txt','r')
    artist.draw(file) { |filehandle, warnings|
      pedigree = filehandle.read
      assert_equal(@@fixtures["label_out"], pedigree)
    }
  end
end
