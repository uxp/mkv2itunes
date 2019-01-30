require "mkv2itunes/base-stream"

module Mkv2itunes
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
