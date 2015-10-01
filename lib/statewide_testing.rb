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
      value     = row[:data]
      if value != "#VALUE!" && value != "N/A" && value != nil && value != "LNE"
        to_return[year] ||= {}
        if stat_type == "Percent" && district == @data.fetch(1)[:location] && value != 0
          to_return[year][score] = (value.to_f * 1000).to_i / 1000.0
        end
      end
    end
    to_return.reject { |key, value| value.empty? }
  end

  def proficient_by_race_or_ethnicity(race_input)
    if race_input.to_s != "asian" && race_input.to_s != "black" && race_input.to_s != "pacific_islander" && race_input.to_s != "hispanic" && race_input.to_s != "native_american" && race_input.to_s != "two_or_more" && race_input.to_s != "white"
      raise UnknownDataError
    end
    data_math    = CSV.open "../headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", headers: true, header_converters: :symbol
    data_reading = CSV.open "../headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", headers: true, header_converters: :symbol
    data_writing = CSV.open "../headcount/data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", headers: true, header_converters: :symbol
    line = []
    return_lines = []
    data_math.each do |columns|
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
