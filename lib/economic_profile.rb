require 'pry'
require 'csv'

class Csv

  def initialize
    @parse = parse
  end

  def from_csv(path)
    #   def from_csv(path)
    #     contents = CSV.open(path), headers: true, header_converters: :symbol
    #     contents
    #   end
    # end
    # path       = File.expand_path("../data", __dir__)
    # repository = DistrictRepository.from_csv(path)
  end

end

class DistrictRepository

  def initialize(districts_data)
    @districts_by_name = districts_data.map { |name, district_data|
    [name.upcase, District.new(name, district_data)]
    }.to_h
  end

  def find_by_name(name)
    @districts_by_name[name.upcase]
  end

  def find_all_matching(name)

  end

end

class District

  attr_accessor :economic_profile, :statewide_testing, :economic_profile

  def initialize(name, data)
    @name              = name
    binding.pry
    @economic_profile  = EconomicProfile.new(data[:economic_profile])
    @statewide_testing = StatewideTesting.new(data[:statewide_testing])
    @enrollment        = Enrollment.new(data[:enrollment])
  end

end

class EconomicProfile

  def initialize(data)
    @data = data
  end

  def free_or_reduced_lunch_by_year
  end

  def free_or_reduced_lunch_in_year(year)
    stats = CSV.open "/Users/edgarduran/code/projects/headcount/headcount/data/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      poverty   = columns[:poverty_level]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_year == year && stat_type == "Percent"
        return value
      end
    end
  end

  def school_aged_children_in_poverty_in_year
  end

  def school_aged_children_in_poverty_in_year(year)
  end

  def title_1_students_by_year
  end

  def title_1_students_in_year(year)
  end

end

class StatewideTesting

  def initialize(data)
    @data = data
  end

  def proficient_by_grade(grade)
  end

  def proficient_by_race_or_ethnicity(race)
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
  end

  def proficient_for_subject_in_year(subject, year)
  end

end

class Enrollment

  def initialize(data)
    @data = data
  end

  def dropout_rate_in_year(year)
  end

  def dropout_rate_by_gender_in_year(year)
  end

  def dropout_rate_by_race_in_year(year)
  end

  def dropout_rate_for_race_or_ethnicity(race)
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year)
  end

  def graduation_rate_by_year
  end

  def graduation_rate_in_year(year)
  end

  def kindergarten_participation_by_year
  end

  def kindergarten_participation_in_year(year)
  end

  def online_participation_by_year
  end

  def online_participation_in_year(year)
  end

  def participation_in_year(year)
  end

  def participation_by_race_or_ethnicity(race)
  end

  def participation_by_race_or_ethnicity_in_year(year)
  end

  def special_education_by_year
  end

  def special_education_in_year(year)
  end

  def remediation_by_year
  end

  def remediation_in_year(year)
  end

end
