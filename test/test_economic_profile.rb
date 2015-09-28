require 'pry'
require 'minitest/test'
require './lib/economic_profile'

class TestEconomicProfile < Minitest::Test
  # def csv_data
  #   CSV.open "../headcount/data/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol
  # end

  def test_free_or_reduced_lunch_by_year
    skip
    expected_result = {"2000"=>"0.27", "2001"=>"0.27528", "2002"=>"0.28509", "2003"=>"0.3", "2004"=>"0.3152", "2005"=>"0.3326", "2006"=>"0.337", "2007"=>"0.34", "2008"=>"0.3536", "2013"=>"0.41959", "2009"=>"0.3838",
                       "2010"=>"0.399", "2011"=>"0.4085", "2012"=>"0.416", "2014"=>"0.41593"}
    assert_equal expected_result, EconomicProfile.new({lunch_thing: 123}).free_or_reduced_lunch_by_year
  end

  def test_free_or_reduced_lunch_in_year
    skip
    assert_equal "0.34793", EconomicProfile.new({lunch_thing: 123})
                                           .free_or_reduced_lunch_in_year("2013")
  end

  def test_school_aged_children_in_poverty_by_year
    skip
    expected_result = {"1995"=>nil, "1997"=>nil, "1999"=>"0.183", "2000"=>"0.201", "2001"=>"0.171",
                       "2002"=>"0.176", "2003"=>"0.173", "2004"=>"0.166", "2005"=>"0.171", "2006"=>"0.172", "2007"=>"0.182",
                       "2008"=>"0.19108", "2009"=>"0.198", "2010"=>"0.18321", "2011"=>"0.205", "2012"=>"0.2", "2013"=>"0.153"}
    assert_equal expected_result, EconomicProfile.new({lunch_thing: 123}).school_aged_children_in_poverty_by_year
  end

  def test_school_aged_children_in_poverty_in_year
    skip
    assert_equal '0.064', EconomicProfile.new({lunch_thing: 123}).school_aged_children_in_poverty_in_year('2012')
  end

  def test_title_1_students_by_year
    skip
    expected_result = {"2009"=>"0.322", "2011"=>"0.152", "2012"=>"0.25123", "2013"=>"0.20049", "2014"=>"0.28519"}
    assert_equal expected_result, EconomicProfile.new({lunch_thing: 123}).title_1_students_by_year
  end

  def test_title_1_students_in_year
    skip
    assert_equal '0.216', EconomicProfile.new({lunch_thing: 123}).title_1_students_in_year('2009')
  end

  def test_first
    path       = File.expand_path("../data", __dir__)
    repository = DistrictRepository.from_csv(path)
    district   = repository.find_by_name("ACADEMY 20")
    assert_equal 0.125, district.economic_profile.free_or_reduced_lunch_in_year(2012)
  end
end

class TestStatewideTesting < Minitest::Test

  def test_proficient_by_grade
    expected = {"2008"=>"0.501", "2009"=>"0.536", "2010"=>"0.504", "2011"=>"0.513", "2012"=>"0.525", "2013"=>"0.50947", "2014"=>"0.51072"}
    assert_equal expected, StatewideTesting.new({lunch_thing: 123}).proficient_by_grade(3)
  end

  def test_proficient_by_race_or_ethnicity
    skip
    expected = ""
    assert_equal expected, StatewideTesting.new({lunch_thing: 123}).proficient_by_grade("asian")
  end


  # def test_district
  #   some = District.new("school", :district)
  #   assert_equal 5, some
  # end
end

class EnrollmentTesting < Minitest::Test
  def test_dropout_rate_in_year
    expected = 0.029
    expected_nil = nil
    assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_in_year("2012")
    assert_equal expected_nil, Enrollment.new({lunch_thing: 123}).dropout_rate_in_year("2300")
  end

  def test_dropout_rate_by_gender_in_year
    expected = {"female"=>"0.027", "male"=>"0.032"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_by_gender_in_year("2012")
  end

  def test_dropout_rate_by_race_in_year
    expected = {"asian"=>"0.016", "black"=>"0.044", "hispanic"=>"0.047", "native american"=>"0.054", "pacific islander"=>"0.038", "two or more"=>"0.017", "white"=>"0.019"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_by_race_in_year("2012")
  end

  def test_dropout_rate_for_race_or_ethnicity
    skip
    expected = {"asian"=>"0.016", "black"=>"0.044", "hispanic"=>"0.047", "native american"=>"0.054", "pacific islander"=>"0.038", "two or more"=>"0.017", "white"=>"0.019"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_for_race_or_ethnicity(:asian)
  end

  def test_dropout_rate_for_race_or_ethnicity_in_year
    skip
    expected = {"asian"=>"0.016", "black"=>"0.044", "hispanic"=>"0.047", "native american"=>"0.054", "pacific islander"=>"0.038", "two or more"=>"0.017", "white"=>"0.019"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
  end

  def test_graduation_rate_by_year
    expected = {"2010"=>"0.724", "2011"=>"0.739", "2012"=>"0.75354", "2013"=>"0.769", "2014"=>"0.773"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).graduation_rate_by_year
  end

  def test_graduation_rate_in_year
    expected = 0.754
    assert_equal expected, Enrollment.new({lunch_thing: 123}).graduation_rate_in_year("2012")
  end

  def test_kindergarten_participation_by_year
    expected = {"2007"=>"0.39465", "2006"=>"0.33677", "2005"=>"0.27807", "2004"=>"0.24014", "2008"=>"0.5357", "2009"=>"0.598", "2010"=>"0.64019", "2011"=>"0.672", "2012"=>"0.695", "2013"=>"0.70263", "2014"=>"0.74118"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year
    expected = 0.695
    assert_equal expected, Enrollment.new({lunch_thing: 123}).kindergarten_participation_in_year("2012")
  end

  def test_online_participation_by_year
    expected = {"2011"=>"16221", "2012"=>"16638", "2013"=>"16215"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).online_participation_by_year
  end

  def test_online_participation_in_year
    expected = 16638.0
    assert_equal expected, Enrollment.new({lunch_thing: 123}).online_participation_in_year("2012")
  end

  def test_participation_by_year
    expected = {"2009"=>"832368", "2010"=>"843316", "2011"=>"854265", "2012"=>"863561", "2013"=>"876999", "2014"=>"889006"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).participation_by_year
  end

  def test_participation_in_year
    expected = 863561.0
    assert_equal expected, Enrollment.new({lunch_thing: 123}).participation_in_year("2012")
  end

  def test_special_education_by_year
    expected = {"2009"=>"0.096", "2011"=>"0.097", "2012"=>"0.098", "2013"=>"0.10056", "2010"=>"0.096", "2014"=>"0.10079"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).special_education_by_year
  end

  def test_remediation_year
    expected = {"2011"=>"0.4", "2010"=>"0.414", "2009"=>"0.392"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).remediation_by_year
  end


end
