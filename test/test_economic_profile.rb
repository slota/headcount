require 'pry'
require 'minitest/test'
require './lib/economic_profile'

class TestEconomicProfile < Minitest::Test

  def test_something_about_lunches
    assert_equal "0.34793", EconomicProfile.new({lunch_thing: 123}).free_or_reduced_lunch_in_year("2013")
  end

  # def test_free_or_reduced_lunch_in_year
  #   path       = File.expand_path("../data", __dir__)
  #   repository = DistrictRepository.from_csv(path)
  #   district   = repository.find_by_name("ACADEMY 20")
  #
  #   assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  # end

  def test_district
    some = District.new("school", :district)
    assert_equal 5, some
  end
end
