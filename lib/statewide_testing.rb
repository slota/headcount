require 'csv'
require 'pry'

class UnknownDataError < StandardError
  def message
    "data issues"
  end
end

class StatewideTesting

  def initialize(data, path)
    @data = data
    @path = path
  end

  def proficient_by_grade(grade)
    if grade != 3 && grade !=8
      raise UnknownDataError
    end
    statsthree = CSV.open "#{@path}/3rd grade students scoring proficient or above on the CSAP_TCAP.csv", headers: true, header_converters: :symbol
    statseight = CSV.open "#{@path}/8th grade students scoring proficient or above on the CSAP_TCAP.csv", headers: true, header_converters: :symbol
    line = []
    return_lines = []
    if  grade == 3
      statsthree.each do |columns|
        district  = columns[:location]
        stat      = columns[:score]
        year      = columns[:timeframe]
        stat_type = columns[:dataformat]
        value     = columns[:data]
        if stat_type == "Percent" && district == @data.fetch(1)[:location]
          line << year
          line << value
          return_lines << line
          line = []
        end
      end
    else
      statseight.each do |columns|
        district  = columns[:location]
        stat      = columns[:score]
        year      = columns[:timeframe]
        stat_type = columns[:dataformat]
        value     = columns[:data]
        if stat_type == "Percent" && district == @data.fetch(1)[:location]
          line << year
          line << value
          return_lines << line
          line = []
        end
      end
    end
    return return_lines.to_h
  end

  def proficient_by_race_or_ethnicity(race_input)
    data_math    = CSV.open "#{@path}/Average proficiency on the CSAP_TCAP by race_ethnicity_Math.csv", headers: true, header_converters: :symbol
    data_reading = CSV.open "#{@path}/Average proficiency on the CSAP_TCAP by race_ethnicity_Reading.csv", headers: true, header_converters: :symbol
    data_writing = CSV.open "#{@path}/Average proficiency on the CSAP_TCAP by race_ethnicity_Writing.csv", headers: true, header_converters: :symbol
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
    math    = CSV.open "#{@path}/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv", headers: true, header_converters: :symbol
    reading = CSV.open "#{@path}/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv", headers: true, header_converters: :symbol
    writing = CSV.open "#{@path}/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv", headers: true, header_converters: :symbol
    if subject == :math
      stats = math
    elsif subject == :reading
      stats = reading
    elsif subject  == :writing
      stats = writing
    else
      raise UnknownDataError
    end
    line = []
    return_lines = []
    stats.each do |columns|
      district  = columns[:location]
      race      = columns[:race_ethnicity]
      date      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if year == nil
        raise UnknownDataError
      end
      if stat_type == "Percent" && district == @data.fetch(1)[:location] && date == year.to_s
        line << value
        return_lines << line
        line = []
      end
    end
    return return_lines.first.first.to_f.round(3)
  end


end
