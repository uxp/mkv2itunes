require 'minitest_helper'

class TestMkv2itunes < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Mkv2itunes::VERSION
  end

  def arguments
    [
      "/Volumes/Media/iTunes/iTunes Media/TV Shows/NOVA/Season 46", # Final directory of the job
      "NOVA.S46E01.Pluto.and.Beyond.720p.HDTV.x264-W4F.nzb",        # Original name of the NZB file
      "NOVA.S46E01.Pluto.and.Beyond.720p.HDTV.x264-W4F",            # Clean version of the job name
      "",                                                           # indexer report number
      "sickbeard",                                                  # user defined category
      "alt.binaries.tv",                                            # group that the NZB was posted in
      "0"                                                           # status of processing
    ]
  end

end
