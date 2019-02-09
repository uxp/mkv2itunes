require 'minitest_helper'

module Mkv2itunes::Streams
  class TestAudioStream < Minitest::Test

    def ffprobe_aac_copy
      #{{{
      {
        "index" => 1,
        "codec_name" => "aac",
        "codec_long_name" => "AAC (Advanced Audio Coding)",
        "profile" => "LC",
        "codec_type" => "audio",
        "codec_time_base" => "1/48000",
        "codec_tag_string" => "[0][0][0][0]",
        "codec_tag" => "0x0000",
        "sample_fmt" => "fltp",
        "sample_rate" => "48000",
        "channels" => 6,
        "channel_layout" => "5.1",
        "bits_per_sample" => 0,
        "r_frame_rate" => "0/0",
        "avg_frame_rate" => "0/0",
        "time_base" => "1/1000",
        "start_pts" => 0,
        "start_time" => "0.000000",
        "disposition" => {
          "default" => 1,
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
          "language" => "eng"
        }
      }
      #}}}
    end

    def ffprobe_opus_transcode
      #{{{
      {
        "index" => 2,
        "codec_name" => "opus",
        "codec_long_name" => "Opus (Opus Interactive Audio Codec)",
        "codec_type" => "audio",
        "codec_time_base" => "1/48000",
        "codec_tag_string" => "[0][0][0][0]",
        "codec_tag" => "0x0000",
        "sample_fmt" => "fltp",
        "sample_rate" => "48000",
        "channels" => 2,
        "channel_layout" => "stereo",
        "bits_per_sample" => 0,
        "r_frame_rate" => "0/0",
        "avg_frame_rate" => "0/0",
        "time_base" => "1/1000",
        "start_pts" => -7,
        "start_time" => "-0.007000",
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
          "language" => "eng"
        }
      }
      #}}}
    end

    def test_aac_copy_to_param
      stream = AudioStream.new ffprobe_aac_copy
      expected = "-codec:a:0 copy"

      refute_nil(stream)
      assert_equal(expected, stream.to_param)
    end

    def test_aac_copy_to_mapping
      stream = AudioStream.new ffprobe_aac_copy
      expected = "-map 0:1"

      refute_nil(stream)
      assert_equal(expected, stream.to_mapping)
    end

    def test_opus_transcode_to_param
      stream = AudioStream.new ffprobe_opus_transcode
      expected = "-codec:a:0 libfdk_aac -ac:a:0 2"

      assert_equal(expected, stream.to_param)
    end

    def test_opus_transcode_to_mapping
      stream = AudioStream.new ffprobe_opus_transcode
      expected = "-map 0:2"

      assert_equal(expected, stream.to_mapping)
    end

  end
end
