require "mkv2itunes/streams/base_stream"

module Mkv2itunes
  module Streams
    class SubtitleStream < BaseStream

      def to_param(index=0)
        index ||= 0
        "-codec:s:#{index} mov_text"
      end

      def subtitle?
        true
      end

    end
  end
end
