class AnalysisLayerTesting < Minitest::Test

  def test_analysis_layer
    assert AnalysisLayer
  end

  def test_initialize_dr
    skip
    path       = File.expand_path("../data", __dir__)
    dr = DistrictRepository.from_csv(path)
    assert_equal "", dr
  end
end
