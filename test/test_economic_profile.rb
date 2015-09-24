require 'pry'
require 'minitest/test'
require './lib/economic_profile'

class TestEconomicProfile < Minitest::Test
  def csv_data
    CSV.open "../headcount/data/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol
  end

  def test_free_or_reduced_lunch_by_year

    expected_result = {"2000"=>"0.27", "2001"=>"0.27528", "2002"=>"0.28509", "2003"=>"0.3", "2004"=>"0.3152", "2005"=>"0.3326", "2006"=>"0.337", "2007"=>"0.34", "2008"=>"0.3536", "2013"=>"0.41959", "2009"=>"0.3838",
                       "2010"=>"0.399", "2011"=>"0.4085", "2012"=>"0.416", "2014"=>"0.41593"}


                assert_equal expected_result, EconomicProfile.new({lunch_thing: 123}, csv_data).free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year
    assert_equal "0.34793", EconomicProfile.new({lunch_thing: 123}, csv_data)
                                           .free_or_reduced_lunch_in_year("2013")
  end

  def test_school_aged_children_in_poverty_by_year
    expected_result = {"1995"=>nil, "1997"=>nil, "1999"=>"0.183", "2000"=>"0.201", "2001"=>"0.171",
                       "2002"=>"0.176", "2003"=>"0.173", "2004"=>"0.166", "2005"=>"0.171", "2006"=>"0.172", "2007"=>"0.182",
                       "2008"=>"0.19108", "2009"=>"0.198", "2010"=>"0.18321", "2011"=>"0.205", "2012"=>"0.2", "2013"=>"0.153"}
    assert_equal expected_result, EconomicProfile.new({lunch_thing: 123}, csv_data).school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year
    assert_equal '0.064', EconomicProfile.new({lunch_thing: 123}, csv_data).school_aged_children_in_poverty_in_year('2012')
  end

  def test_title_1_students_by_year
    expected_result = {"2009"=>"0.322", "2011"=>"0.152", "2012"=>"0.25123", "2013"=>"0.20049", "2014"=>"0.28519"}

    assert_equal expected_result, EconomicProfile.new({lunch_thing: 123}, csv_data).title_1_students_by_year
  end

  def test_title_1_students_by_year
    assert_equal '0.22907', EconomicProfile.new({lunch_thing: 123}, csv_data).title_1_students_in_year('2012')
  end

  def test_free_or_reduced_lunch_in_year
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")

    assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end
  #
  # def test_district
  #   some = District.new("school", :district)
  #   assert_equal 5, some
  # end
end
