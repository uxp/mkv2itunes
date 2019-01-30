require "mkv2itunes/base-stream"

module Mkv2itunes
  class AudioStream < BaseStream

    def audio?
      true
    end

    def may_be_english?
      data["tags"].any? do |k,v|
        k.downcase == 'language' && %w[und unk eng].include?(v)
      end
    end

    def not_foreign?
      data["tags"].none? do |k,v|
        k.downcase == 'language' && %w[eng].include?(v)
      end
    end

    def <=>(o)
      codecs = %w[ idxpad aac truehd dca dts eac3 ac3 opus ]
      codecs.index(codec_name) <=> codecs.index(o.codec_name)
    end

    def channels
      data["channels"]
    end

    def to_mapping
      "-map 0:#{data['index']}"
    end

    def to_param(index = 0)
      index ||= 0

      case codec_name
      when 'aac'
        "-codec:a:#{index} copy"

      else
        "-codec:a:#{index} libfdk_aac -ac:a:#{index} 2"
      end
    end

  end
end
