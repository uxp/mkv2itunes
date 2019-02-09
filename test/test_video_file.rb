require "minitest_helper"
require "mkv2itunes/video_file"

module Mkv2itunes

  class TestVideoFile < Minitest::Test
    def filename
      "Testing.S99E42.Example.Video.File.720p.WEB.AAC.H264-ABC.mkv"
    end

    def ffprobe_hd_copy
      #{{{
      OpenStruct.new(
        :video_streams => [
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
        ],
        :audio_streams => [
          {
            "index" => 1,
            "codec_name" => "aac",
            "codec_type" => "audio",
            "sample_fmt" => "fltp",
            "sample_rate" => "44100",
            "channels" => 2,
            "channel_layout" => "stereo",
            "bitrate" => "33769",
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
              "langugage" => "und"
            }
          }
        ],
        :subtitle_streams => [
          {
            "index" => 2,
            "codec_name" => "subrip",
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
              "langugage" => "eng"
            }
          }
        ]
      )
      #}}}
    end

    def ffprobe_hd_transcode
      #{{{
      OpenStruct.new(
        :video_streams => [
          {
            "index" => 0,
            "codec_name" => "vp9",
            "codec_long_name" => "Google VP9",
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
        ],
        :audio_streams => [
          {
            "index" => 1,
            "codec_name" => "eac3",
            "codec_long_name" => "ATSC A/52B (AC-3, E-AC-3)",
            "codec_type" => "audio",
            "sample_fmt" => "fltp",
            "sample_rate" => "48000",
            "channels" => 6,
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
        ],
        :subtitle_streams => [
          {
            "index" => 2,
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
              "langugage" => "eng"
            }
          },
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
              "langugage" => "eng",
              "title" => "SDH"
            }
          }
        ]
      )
      #}}}
    end

    def test_basic_init
      file = VideoFile.new(ffprobe_hd_copy, filename)
      refute_nil(file)
    end

    def test_stream_selection
      file = VideoFile.new(ffprobe_hd_copy, filename)

      refute_nil(file.video_stream)
      assert(file.video_stream.video?)
    end

    def test_hd_copy_to_params
      file = VideoFile.new(ffprobe_hd_copy, filename)
      expected = "-map 0:0 -map 0:1 -map 0:2 -codec:v:0 copy -codec:a:0 copy -codec:s:0 mov_text"

      assert_equal(expected, file.to_param)
    end

    def test_hd_transcode_to_params
      file = VideoFile.new(ffprobe_hd_transcode, filename)
      expected = "-map 0:0 -map 0:1 -map 0:2 -map 0:3 -codec:v:0 libx264 -preset slow -codec:a:0 libfdk_aac -ac:a:0 2 -codec:s:0 mov_text -codec:s:1 mov_text"

      assert_equal(expected, file.to_param)
    end

    def test_file_rename
      file = VideoFile.new(ffprobe_hd_copy, filename)
      expected = "./Testing.S99E42.Example.Video.File.720p.WEB.AAC.H264-ABC.m4v"

      assert_equal(expected, file.output_name)
    end

    def test_file_rename_with_path
      original = "/media/downloads/TV Shows/Testing.S99E42.Example.Video.File.720p.WEB.AAC.H264-ABC/Testing.S99E42.Example.Video.File.720p.WEB.AAC.H264-ABC.mkv"
      expected = "/media/downloads/TV Shows/Testing.S99E42.Example.Video.File.720p.WEB.AAC.H264-ABC/Testing.S99E42.Example.Video.File.720p.WEB.AAC.H264-ABC.m4v"
      file = VideoFile.new(ffprobe_hd_copy, original)

      assert_equal(expected, file.output_name)
    end


  end
end
