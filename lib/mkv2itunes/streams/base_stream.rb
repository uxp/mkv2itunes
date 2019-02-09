
module Mkv2itunes
  module Streams

    class BaseStream
      include Comparable
      attr_reader :data

      def initialize(s)
        @data = s
      end

      def audio?
        false
      end

      def video?
        false
      end

      def subtitle?
        false
      end

      def to_param
        ""
      end

      def <=>(o)
      end

      def input_index
        data["index"]
      end

      def out_index
        raise "undefined"
      end

      def codec_name
        data["codec_name"]
      end

      def to_mapping
        "-map 0:#{data['index']}"
      end
    end

  end
end
