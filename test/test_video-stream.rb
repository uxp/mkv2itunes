
module Mkv2itunes

  class TestVideoStream < Minitest::Test

    def ffprobe_hd_copy
      #{{{
      {
        "index" => 0,
        "codec_name" => "h264",
        "codec_type" => "video",
        "width" => 1920,
        "height" => 1080,
        "coded_width" => 1920,
        "coded_height" => 1088,
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
          "langugage" => "eng"
        }
      }
      #}}}
    end

    def ffprobe_sd_copy
      #{{{
      {
        "index" => 0,
        "codec_name" => "h264",
        "codec_type" => "video",
        "width" => 848,
        "height" => 480,
        "coded_width" => 854,
        "coded_height" => 480,
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
          "langugage" => "eng"
        }
      }
      #}}}
    end

    def ffprobe_hd_transcode
      #{{{
      {
        "index" => 0,
        "codec_name" => "vp9",
        "codec_type" => "video",
        "width" => 1920,
        "height" => 1080,
        "coded_width" => 1920,
        "coded_height" => 1080,
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

    def test_hd_copy_identification
      stream = VideoStream.new(ffprobe_hd_copy)

      assert(stream.hd?)
    end

    def test_hd_transcode_identification
      stream = VideoStream.new(ffprobe_hd_transcode)

      assert(stream.hd?)
    end

    def test_hd_copy_to_param
      stream = VideoStream.new(ffprobe_hd_copy)
      expected = "-codec:v:0 copy"

      assert_equal(expected, stream.to_param)
    end

    def test_sd_copy_identification
      stream = VideoStream.new(ffprobe_sd_copy)

      refute(stream.hd?)
    end

    def test_sd_copy_to_param
      stream = VideoStream.new(ffprobe_sd_copy)
      expected = "-codec:v:0 copy"

      assert_equal(expected, stream.to_param)
    end

    def test_hd_transcode_to_param
      stream = VideoStream.new(ffprobe_hd_transcode)
      expected = "-codec:v:0 libx264 -preset slow"

      assert_equal(expected, stream.to_param)
    end

    def test_hd_transcode_to_param_secondary_stream
      stream = VideoStream.new(ffprobe_hd_transcode)
      expected = "-codec:v:2 libx264 -preset slow"

      assert_equal(expected, stream.to_param(2))
    end

  end
end
