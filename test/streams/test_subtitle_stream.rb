require "minitest_helper"

module Mkv2itunes::Streams
  class TestSubtitleStream < Minitest::Test

    def ffprobe
      #{{{
      {
        "index" => 3,
        "codec_name" => "subrip",
        "codec_long_name" => "SubRip subtitle",
        "codec_type" => "subtitle",
        "disposition" => {
          "default" => 0,
          "dub" => 0,
          "original" => 0,
          "comment" => 0,
          "lyrics" => 0,
          "karaoke" => 0,
          "forced" => 0,
          "hearing_impaired" => 0,
          "visual_impaired" => 0,
          "clean_effects" => 0,
          "attached_pic" => 0,
          "timed_thumbnails" => 0
        },
        "tags" => {
          "language" => "eng",
          "BPS-eng" => "55"
        }
      }
      #}}}
    end


    def test_creation
      stream = SubtitleStream.new ffprobe
      refute_nil stream
    end

    def test_subtitle_to_param
      stream = SubtitleStream.new ffprobe
      expected = "-codec:s:0 mov_text"

      refute_nil(stream)
      assert_equal(expected, stream.to_param)
    end

    def test_subtitle_to_mapping
      stream = SubtitleStream.new ffprobe
      expected = "-map 0:3"

      refute_nil(stream)
      assert_equal(expected, stream.to_mapping)
    end


  end
end
