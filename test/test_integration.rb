require "minitest_helper"
require "mkv2itunes"

module Mkv2itunes

  class TestIntegration < Minitest::Test

    def file_test_s01e01_jellyfish_1080p_web_dl_aac2_h264
      File.expand_path(File.join(File.dirname(__FILE__), 'files', 'Test.S01E01.Jellyfish.1080p.WEB.DL.AAC2.H264-JELLYFISH_US.mkv'))
    end

    def file_test_s01e01_jellyfish_1080p_bluray_dd5_1_hvec_x265
      File.expand_path(File.join(File.dirname(__FILE__), 'files', 'Test.S01E01.Jellyfish.1080p.BLURAY.DD5.1.HVEC.x265-JELLYFISH_US.mkv'))
    end

    def file_test_s01e01_jellyfish_1080p_web_dl_hvec_10
      File.expand_path(File.join(File.dirname(__FILE__), 'files', 'Test.S01E01.Jellyfish.1080p.WEB.DL.HVEC-10-JELLYFISH_US.mkv'))
    end

    def test_loading_file_test_s01e01_jellyfish_1080p_web_dl_aac2_h264
      file = Mkv2itunes::Conversion.load(file_test_s01e01_jellyfish_1080p_web_dl_aac2_h264)

      assert_equal "Test.S01E01.Jellyfish.1080p.WEB.DL.AAC2.H264-JELLYFISH_US.mkv", file.input_name
      assert_equal "./Test.S01E01.Jellyfish.1080p.WEB.DL.AAC2.H264-JELLYFISH_US.m4v", file.output_name
      assert_equal "-map 0:0 -map 0:1 -codec:v:0 copy -codec:a:0 copy", file.to_param
    end

    def test_loading_file_test_s01e01_jellyfish_1080p_bluray_dd5_1_hvec_x265
      file = Mkv2itunes::Conversion.load(file_test_s01e01_jellyfish_1080p_bluray_dd5_1_hvec_x265)

      assert_equal "Test.S01E01.Jellyfish.1080p.BLURAY.DD5.1.HVEC.x265-JELLYFISH_US.mkv", file.input_name
      assert_equal "./Test.S01E01.Jellyfish.1080p.BLURAY.DD5.1.HVEC.x265-JELLYFISH_US.m4v", file.output_name
      assert_equal "-map 0:0 -map 0:1 -codec:v:0 libx264 -preset slow -codec:a:0 libfdk_aac -ac:a:0 2", file.to_param
    end

  end
end
