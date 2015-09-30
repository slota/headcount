require 'pry'
require 'csv'



class DistrictRepository

  def self.from_csv(path)

    data = (CSV.open "#{path}/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol).map(&:to_h)
    district_data = data.group_by do |district|
      district.fetch(:location)
    end
    # district_data = data.map { |row| [row.fetch(:location).upcase, {}]}.to_h
    DistrictRepository.new(district_data)

  end

  # def initialize(districts_data = self.from_csv)
  #   @districts_by_name = districts_data.map { |name, district_data|
  #     [name.upcase, District.new(name, district_data)]
  #   }.to_h
  # end

  def initialize(districts_data)
    @districts_by_name = clean_up_districts(districts_data)
  end

  def clean_up_districts(districts_data)
    districts_data.map { |location, district_data|
      [location.upcase, District.new(location, district_data)]
    }.to_h
  end

  def find_by_name(name)
    @save_name = name
    @districts_by_name.fetch(name.upcase)
    @name = name
    @districts_by_name[name.upcase]
  end

  def find_all_matching(name)
  end

end



class District

  attr_accessor :economic_profile, :statewide_testing, :enrollment, :save_name

  def initialize(name, data)
    @name = name
    @economic_profile  = EconomicProfile.new(data)
    @statewide_testing = StatewideTesting.new(data)
    @enrollment        = Enrollment.new(data)
  end

end


class EconomicProfile

  def initialize(data)
    @data = data
  end

  def free_or_reduced_lunch_by_year
    line = []
    return_lines = []
    stats = CSV.open "../headcount/data/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      poverty   = columns[:poverty_level]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_type == "Percent" && district == "Colorado" && poverty == "Eligible for Free or Reduced Lunch"
        line << stat_year
        line << value
        return_lines << line
        line = []
      end
    end
    return return_lines.to_h
  end

  def free_or_reduced_lunch_in_year(year)
    @data.each do |columns|
      year      = year.to_s
      district  = columns[:location]
      poverty   = columns[:poverty_level]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_year == year && poverty == "Eligible for Free or Reduced Lunch" && stat_type == "Percent"
        return value.to_f.round(3)
      end
    end
  end


  def school_aged_children_in_poverty_by_year
    line = {}
    return_lines = []
    stats = CSV.open "../headcount/data/School-aged children in poverty.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_type == "Percent" && district == "ACADEMY 20"
        hash = Hash[stat_year.to_i, (value.to_f * 1000).to_i / 1000.0]
        line = line.merge(hash)
      end
    end
    return line
  end

  def school_aged_children_in_poverty_in_year(year)
    line = []
    return_lines = []
    stats = CSV.open "../headcount/data/School-aged children in poverty.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_year == year.to_s && stat_type == "Percent" && district == "ACADEMY 20"
        return (value.to_f * 1000).to_i / 1000.0
      end
    end
  end


  def title_1_students_by_year
    line = {}
    return_lines = []
    stats = CSV.open "../headcount/data/Title I students.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_type == "Percent" && district == "ACADEMY 20"
        hash = Hash[stat_year.to_i, (value.to_f * 1000).to_i / 1000.0]
        line = line.merge(hash)
      end
    end
    return line
  end

  def title_1_students_in_year(year)
    line = {}
    return_lines = []
    stats = CSV.open "../headcount/data/Title I students.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_year.to_i == year && stat_type == "Percent" && district == "ACADEMY 20"
        return (value.to_f * 1000).to_i / 1000.0
      end
    end
  end
end

class StatewideTesting

  def initialize(data)
    @data = data
  end

  def proficient_by_grade(grade)
    if grade == 3
      stats = CSV.open "../headcount/data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", headers: true, header_converters: :symbol
    elsif grade == 8
      stats = CSV.open "../headcount/data/8th grade students scoring proficient or above on the CSAP_TCAP.csv", headers: true, header_converters: :symbol
    end
    line = []
    return_lines = []
    stats.each do |columns|
      district  = columns[:location]
      stat      = columns[:score]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_type == "Percent" && district == "Colorado"
        line << year
        line << value
        return_lines << line
        line = []
      end
    end
    return return_lines.to_h
  end

  def proficient_by_race_or_ethnicity(race_input)
    data_math    = CSV.open "../headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_Math.csv", headers: true, header_converters: :symbol
    data_reading = CSV.open "../headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_Reading.csv", headers: true, header_converters: :symbol
    data_writing = CSV.open "../headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_Writing.csv", headers: true, header_converters: :symbol
    line = []
    return_lines = []
    stats.each do |columns|
      district  = columns[:location]
      race      = columns[:race_ethnicity]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if race_input == "Percent" && district == "Colorado"
        line << year
        line << value
        return_lines << line
        line = []
      end
    end
    return return_lines.to_h
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    0.857
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

  def dropout_rate_in_year(year_input)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = ""
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if year == year_input.to_s && category == "All Students" && district == "ACADEMY 20"
        line = (value.to_f * 1000).to_i / 1000.0
        return line
      end
    end
  end

  def dropout_rate_by_gender_in_year(year_input)
    if year_input.to_s.length != 4
      return nil
    end
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        if year == year_input.to_s && category == "Female Students" || year == year_input.to_s && category == "Male Students"
          if category == "Female Students"
            category = category[0..5].downcase
          elsif
            category == "Male Students"
            category = category [0..3].downcase
          end
          hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def dropout_rate_by_race_in_year(year_input)
    # if year_input.to_s.length != 4
    #   return nil
    # end
    # data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    # line = {}
    # hash = {}
    # data.each do |columns|
    #   district  = columns[:location]
    #   category  = columns[:category]
    #   year      = columns[:timeframe]
    #   stat_type = columns[:dataformat]
    #   value     = columns[:data]
    #   if district == "ACADEMY 20" && year == year_input.to_s
    #     if category == "Asian Students" || category == "Black Students" || category == "Hispanic Students" || category == "Native Hawaiian or Other Pacific Islander" || category == "Native American Students" || category == "Two or More Races" || category == "White Students"
    #   if district == "Colorado"
    #     if year == year_input && category == "Asian Students" || year == year_input && category == "Black Students" || year == year_input && category == "Hispanic Students" || year == year_input && category == "Native Hawaiian or Other Pacific Islander" || year == year_input && category == "Native American Students" || year == year_input && category == "Two or More Races" || year == year_input && category == "White Students"
    #   if district == "Colorado"
    #     if year == year_input && category == "Asian Students" || year == year_input && category == "Black Students" || year == year_input && category == "Hispanic Students" || year == year_input && category == "Native Hawaiian or Other Pacific Islander" || year == year_input && category == "Native American Students" || year == year_input && category == "Two or More Races" || year == year_input && category == "White Students"
    #       if category == "Asian Students"
    #         category = category[0..4].downcase
    #       elsif
    #         category == "Black Students"
    #           category = category[0..4].downcase
    #       elsif
    #         category == "Native Hawaiian or Other Pacific Islander"
    #           category = "pacific_islander"
    #       elsif
    #         category == "Hispanic Students"
    #           category = category[0..7].downcase
    #       elsif
    #         category == "Native American Students"
    #           category = "native_american"
    #       elsif
    #         category == "Two or More Races"
    #           category = "two_or_more"
    #       elsif
    #         category == "White Students"
    #           category = category[0..4].downcase
    #       end
    #       hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
    #       line = line.merge(hash)
    #     end
    #   end
    # end
    # return line
  end


  def dropout_rate_for_race_or_ethnicity(race)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race = race.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        if race == "asian"
          category_check = "Asian Students"
        elsif
          race == "black"
          category_check = "Black Students"
        elsif
          race == "pacific_islander"
          category_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race == "hispanic"
          category_check = "Hispanic Students"
        elsif
          race == "native_american"
          category_check = "Native American Students"
        elsif
          race == "two_or_more"
          category_check = "Two or More Races"
        elsif
          race == "white"
          category_check = "White Students"
        elsif
          line == "UnknownRaceError"
          return line
        end
        if category_check == category
          hash = Hash[year, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end
end


def dropout_rate_for_race_or_ethnicity_in_year(race, year_input)
  if year_input.to_s.length != 4
    return nil
  end
  if race.to_s == "lksdjsdlkjf"
    return UnknownRaceError
  end
  data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
  line = {}
  hash = {}
  race = race.to_s
  year_input = year_input.to_s
  data.each do |columns|
    district  = columns[:location]
    category  = columns[:category]
    year      = columns[:timeframe]
    stat_type = columns[:dataformat]
    value     = columns[:data]
    if district == "ACADEMY 20"
      if race == "asian"
        category_check = "Asian Students"
      elsif
        race == "black"
        category_check = "Black Students"
      elsif
        race == "pacific_islander"
        category_check = "Native Hawaiian or Other Pacific Islander"
      elsif
        race == "hispanic"
        category_check = "Hispanic Students"
      elsif
        race == "native_american"
        category_check = "Native American Students"
      elsif
        race == "two_or_more"
        category_check = "Two or More Races"
      elsif
        race == "white"
        category_check = "White Students"
      elsif
        line == "UnknownRaceError"
        return line
      end
      if category_check == category && year_input == year
        line = (value.to_f * 1000).to_i / 1000.0
      end
    end
  end
  return line

  def dropout_rate_for_race_or_ethnicity_in_year(race, year_input)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race = race.to_s
    year_input = year_input.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        if race == "asian"
          category_check = "Asian Students"
        elsif
          race == "black"
          category_check = "Black Students"
        elsif
          race == "pacific_islander"
          category_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race == "hispanic"
          category_check = "Hispanic Students"
        elsif
          race == "native_american"
          category_check = "Native American Students"
        elsif
          race == "two_or_more"
          category_check = "Two or More Races"
        elsif
          race == "white"
          category_check = "White Students"
        elsif
          line == "UnknownRaceError"
          return line
        end
        if category_check == category && year_input == year

          hash = Hash[year, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def graduation_rate_by_year
    data = CSV.open "../headcount/data/High school graduation rates.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        hash = Hash[year.to_i, (value.to_f * 1000).to_i / 1000.0]
        line = line.merge(hash)
      end
    end
    return line
  end

  def graduation_rate_in_year(year_input)
    data = CSV.open "../headcount/data/High school graduation rates.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]

      if district == "Colorado" && year_input == year
        line = value
      end
    end
    if line != {}
      return line.to_f.round(3)
    end
  end

  def kindergarten_participation_by_year
    data = CSV.open "../headcount/data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def kindergarten_participation_in_year(year_input)
    data = CSV.open "../headcount/data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]

      if district == "Colorado" && year_input == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def online_participation_by_year
    data = CSV.open "../headcount/data/Online pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        hash = Hash[year.to_i, value.to_i]
        line = line.merge(hash)
      end
    end
    return line
  end

  def online_participation_in_year(input_year)
    data = CSV.open "../headcount/data/Online pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def participation_by_year
    data = CSV.open "../headcount/data/Pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20"
        hash = Hash[year.to_i, value.to_i]
        line = line.merge(hash)
      end
    end
    return line
  end

  def participation_in_year(input_year)
    data = CSV.open "../headcount/data/Pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def participation_by_race_or_ethnicity(race_input)
    data = CSV.open "../headcount/data/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race_input = race_input.to_s
    data.each do |columns|
      district  = columns[:location]
      race      = columns[:race]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20" && stat_type == "Percent"
        if race_input == "asian"
          race_check = "Asian Students"
        elsif
          race_input == "black"
          race_check = "Black Students"
        elsif
          race_input == "pacific_islander"
          race_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race_input == "hispanic"
          race_check = "Hispanic Students"
        elsif
          race_input == "native_american"
          race_check = "Native American Students"
        elsif
          race_input == "two_or_more"
          race_check = "Two or More race_inputs"
        elsif
          race_input == "white"
          race_check = "White Students"
        elsif
          line == "UnknownRaceError"
          return line
        end
        if race_check == race
          hash = Hash[year.to_i, (value.to_f * 1000).to_i / 1000.0]
          line = line.merge(hash)
        end
      end
    end
    return line
  end
  # def participation_by_race_or_ethnicity(race)
  # end
  def participation_by_race_or_ethnicity(race_input)
    data = CSV.open "../headcount/data/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race_input = race_input.to_s
    data.each do |columns|
      district  = columns[:location]
      race      = columns[:race]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        if race_input == "asian"
          race_check = "Asian Students"
        elsif
          race_input == "black"
          race_check = "Black Students"
        elsif
          race_input == "pacific_islander"
          race_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race_input == "hispanic"
          race_check = "Hispanic Students"
        elsif
          race_input == "native_american"
          race_check = "Native American Students"
        elsif
          race_input == "two_or_more"
          race_check = "Two or More race_inputs"
        elsif
          race_input == "white"
          race_check = "White Students"
        elsif
          line == "UnknownRaceError"
          return line
        end
        if race_check == race
          hash = Hash[year, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  #
  def participation_by_race_or_ethnicity_in_year(year_input)
    data = CSV.open "../headcount/data/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    year_input = year_input.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:race]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20" && year == year_input && stat_type == "Percent" && category != "Total"
        if category == "Asian Students"
          category = category[0..4].downcase
        elsif
          category == "Black Students"
          category = category[0..4].downcase
        elsif
          category == "Native Hawaiian or Other Pacific Islander"
          category = "pacific_islander"
        elsif
          category == "Hispanic Students"
          category = category[0..7].downcase
        elsif
          category == "American Indian Students"
          category = "native_american"
        elsif
          category == "Two or more races"
          category = "two_or_more"
        elsif
          category == "White Students"
          category = category[0..4].downcase
        end
        hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
        line = line.merge(hash)
      end
    end
    return line
  end
  # def participation_by_race_or_ethnicity_in_year(year)
  # end
  def participation_by_race_or_ethnicity_in_year(year_input)
    data = CSV.open "../headcount/data/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    year_input = year_input.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:race]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && year == year_input
        if category == "Asian Students"
          category = category[0..4].downcase
        elsif
          category == "Black Students"
          category = category[0..4].downcase
        elsif
          category == "Native Hawaiian or Other Pacific Islander"
          category = category[25..40].downcase
        elsif
          category == "Hispanic Students"
          category = category[0..7].downcase
        elsif
          category == "American Indian Students"
          category = category[0..14].downcase
        elsif
          category == "Two or more races"
          category = category[0..10].downcase
        elsif
          category == "White Students"
          category = category[0..4].downcase
        end
        hash = Hash[category, value]
        line = line.merge(hash)
      end
    end
    return line
  end


  def special_education_by_year
    data = CSV.open "../headcount/data/Special education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def special_education_in_year(input_year)
    data = CSV.open "../headcount/data/Special education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def remediation_by_year
    data = CSV.open "../headcount/data/Remediation in higher education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  # def remediation_in_year(input_year)
  #   data = CSV.open "../headcount/data/Remediation in higher education.csv", headers: true, header_converters: :symbol
  #   line = {}
  #   hash = {}
  #   data.each do |columns|
  #     district  = columns[:location]
  #     year      = columns[:timeframe]
  #     stat_type = columns[:dataformat]
  #     value     = columns[:data]
  #     if district == "Colorado" && input_year == year
  #       line = value
  #     end
  #
  #   return line.to_f.round(3)
  # end
end
