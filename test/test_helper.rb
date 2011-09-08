require 'test/unit'
require 'yaml'
class Test::Unit::TestCase
  @@fixtures = {}
  def self.fixtures fixture
    # load and cache the YAML
    item = YAML.load_file("test/fixtures/#{fixture.to_s}.yml")
    item.each do |name, value|
      @@fixtures[name] = value
    end
  end
end
