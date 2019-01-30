require "json"

module Mkv2itunes
  class FileParser
    def initialize(file)
      @data = JSON.parse %x[#{ffprobe} -i "#{file}" -print_format json -show_streams 2>/dev/null]
    end

    def video_streams
      @data['streams'].select {|s| s['codec_type'] == 'video'}
    end

    def audio_streams
      @data['streams'].select {|s| s['codec_type'] == 'audio'}
    end

    def subtitle_streams
      @data['streams'].select {|s| s['codec_type'] == 'subtitle'}
    end

    private
    def ffmpeg
      `which ffmpeg`.chomp
    end
  end
end
