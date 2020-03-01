# Data loader with memorization
require 'json'

class DataLoader
  def self.load(source = ENV['LANG_DATA'])
    @data ||= JSON.parse(File.read(source))
  end
end
