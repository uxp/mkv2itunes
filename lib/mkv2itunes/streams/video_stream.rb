require "mkv2itunes/streams/base_stream"

module Mkv2itunes
  module Streams
    class VideoStream < BaseStream
      def video?
        true
      end

      def hd?
        data["height"] > 480
      end

      def to_param(index = 0)
        index ||= 0

        if codec_name =~ /h264/
          "-codec:v:#{index} copy"
        else
          "-codec:v:#{index} libx264 -preset slow"
        end
      end

    end
  end
end
