require "mkv2itunes/version"
require "mkv2itunes/conversion"

module Mkv2itunes

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
  end

end
