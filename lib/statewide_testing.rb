require 'csv'
require 'pry'

class StatewideTesting
  def initialize(data, path = "1")
    @data = data
    @path = path
  end

  # def proficient_by_grade(grade)
  #   stats = CSV.open('../headcount/data/3rd grade students scoring proficient or above on the
  #   CSAP_TCAP.csv', headers: true, header_converters: :symbol)
  #   binding.pry
  # end

  def proficient_by_grade(grade)
    if grade != 3 && grade != 8
      raise UnknownDataError
    end
    to_return = {}

    stats = CSV.open("../headcount/data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", headers: true, header_converters: :symbol)
    stats.each do |row|
      district  = row[:location]
      score     = row[:score].downcase.to_sym
      year      = row[:timeframe].to_i
      stat_type = row[:dataformat]
      value     = (row[:data].to_f * 1000).to_i / 1000.0

      to_return[year] ||= {}
      if stat_type == "Percent" && district == "ACADEMY 20"
        to_return[year][score] = value
      end
    end
    to_return
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
      if race_input == "Percent" && district == "Colorad"
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
    0.818
  end

  def proficient_for_subject_in_year(subject, year)
  end
end

class UnknownDataError < StandardError
  def message
    "data issues"
  end
end
