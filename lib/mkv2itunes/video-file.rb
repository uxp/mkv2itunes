require "json"
require "mkv2itunes/video-stream"
require "mkv2itunes/audio-stream"
require "mkv2itunes/subtitle-stream"

module Mkv2itunes
  class VideoFile

     def initialize(file, name)
      @streams = Array.new
      file.video_streams.each {|v| @streams.push(VideoStream.new(v))}
      file.audio_streams.each {|a| @streams.push(AudioStream.new(a))}
      file.subtitle_streams.each {|s| @streams.push(SubtitleStream.new(s))}

      @name = name
    end

    def video_stream
      @streams.select(&:video?).max
    end

    def audio_streams
      @streams.select(&:audio?)
    end

    def subtitle_streams
      @streams.select(&:subtitle?)
    end

    def input_name
      @name
    end

    def to_param
      [ video_to_mapping, audio_to_mapping, subtitle_to_mapping,
        video_to_param, audio_to_param, subtitle_to_param ].flatten.join(' ')
    end

    def output_name
      dir = File.dirname(@name)
      file_parts = File.basename(@name).split('.')
      file_parts.pop
      file_parts.push 'm4v'

      File.join(dir, file_parts.join('.'))
    end


    private
    def video_to_param
      video_stream.to_param
    end

    def video_to_mapping
      video_stream.to_mapping
    end

    def audio_to_param
      audio_streams.map.with_index {|x,i| x.to_param(i) }
    end

    def audio_to_mapping
      audio_streams.map(&:to_mapping)
    end

    def subtitle_to_param
      subtitle_streams.map.with_index {|x,i| x.to_param(i) }
    end

    def subtitle_to_mapping
      subtitle_streams.map(&:to_mapping)
    end
  end
end
