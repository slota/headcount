require 'csv'
require 'pry'

class Enrollment

  def initialize(data, path)
    @data = data
    @path = path
  end

  def dropout_rate_in_year(year_input)
    data = CSV.open "#{@path}/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
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
    data = CSV.open "#{@path}/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
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
    if year_input.to_s.length != 4
      return nil
    end
    data = CSV.open "#{@path}/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      # if district == "ACADEMY 20" && year == year_input.to_s
      if district == "ACADEMY 20"
        if category == "Asian Students" || category == "Black Students" || category == "Native Hawaiian or Other Pacific Islander" || category == "Hispanic Students" || category == "Native American Students" || category == "Two or More Races" || category == "White Students"
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
            category == "Native American Students"
            category = "native_american"
          elsif
            category == "Two or More Races"
            category = "two_or_more"
          elsif
            category == "White Students"
            category = category[0..4].downcase
          end
          hash = Hash[category.to_sym, (value.to_f * 1000).to_i / 1000.0]
          line = line.merge(hash)
        end
      end
    end
    return line
  end


  def dropout_rate_for_race_or_ethnicity(race)
    if race == :wat
      raise UnknownRaceError
    end
    data = CSV.open "#{@path}/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
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
          year = year.to_i
          hash = Hash[year, (value.to_f * 1000).to_i / 1000.0]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year_input)
    if year_input.to_s.length > 4
      return nil
    end
    if race.to_s == "lksdjsdlkjf"
      raise UnknownRaceError
    end

    data = CSV.open "#{@path}/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    if year_input.to_s.length != 4
      return line
    end
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
  end

  def graduation_rate_by_year
    data = CSV.open "#{@path}/High school graduation rates.csv", headers: true, header_converters: :symbol
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
    data = CSV.open "#{@path}/High school graduation rates.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]

      if district == "ACADEMY 20" && year_input.to_s == year
        line = value
      end
    end
    if line != {}
      return line.to_f.round(3)
    end
  end

  def kindergarten_participation_by_year
    data = CSV.open "#{@path}/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
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

  def kindergarten_participation_in_year(year_input)
    if year_input.to_s.length > 4
      return nil
    end
    data = CSV.open "#{@path}/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]

      if district == "ACADEMY 20" && year_input == year.to_i
        line = (value.to_f * 1000).to_i / 1000.0
      end
    end
    return line
  end

  def online_participation_by_year
    data = CSV.open "#{@path}/Online pupil enrollment.csv", headers: true, header_converters: :symbol
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

  def online_participation_in_year(year_input)
    if year_input.to_s.length > 4
      return nil
    end
    data = CSV.open "#{@path}/Online pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20" && year_input == year.to_i
        line = (value.to_f * 1000).to_i / 1000.0
      end
    end
    return line
  end

  def participation_by_year
    data = CSV.open "#{@path}/Pupil enrollment.csv", headers: true, header_converters: :symbol
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

  def participation_in_year(year_input)
    if year_input.to_s.length > 4
      return nil
    end
    data = CSV.open "#{@path}/Pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20" && year_input.to_s == year
        line = value.to_i
      end
    end
    return line
  end

  def participation_by_race_or_ethnicity(race_input)
    if race_input == :wat
      raise UnknownRaceError
    end
    data = CSV.open "#{@path}/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
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


  #
  def participation_by_race_or_ethnicity_in_year(year_input)
    if year_input.to_s.length > 4
      return nil
    end
    data = CSV.open "#{@path}/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
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


  def special_education_by_year
    data = CSV.open "#{@path}/Special education.csv", headers: true, header_converters: :symbol
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

  def special_education_in_year(input_year)
    if input_year.to_s.length > 4
      return nil
    end
    data = CSV.open "#{@path}/Special education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20" && input_year == year.to_i
        line = (value.to_f * 1000).to_i / 1000.0
      end
    end
    return line
  end

  def remediation_by_year
    data = CSV.open "#{@path}/Remediation in higher education.csv", headers: true, header_converters: :symbol
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

  def remediation_in_year(input_year)
    if input_year.to_s.length > 4
      return nil
    end
    data = CSV.open "#{@path}/Remediation in higher education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "ACADEMY 20" && input_year == year.to_i
        line =  (value.to_f * 1000).to_i / 1000.0
      end
    end
    return line
  end
end

class UnknownRaceError < StandardError
  def message
    "race issues"
  end
end
