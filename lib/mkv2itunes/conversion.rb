require "mkv2itunes/video_file"
require "mkv2itunes/file_parser"

module Mkv2itunes

  class Conversion

    def self.load(file)
      name = File.basename(file)
      
      VideoFile.new(FileParser.new(file), name)
    end
  end
end
