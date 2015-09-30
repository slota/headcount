require 'pry'
require 'csv'

class EconomicProfile

  def initialize(data, path)
    @data = data
    @path = path
  end

  def free_or_reduced_lunch_by_year
    line = {}
    stats = CSV.open "#{@path}/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol
    stats.each do |columns|
      district  = columns[:location]
      poverty   = columns[:poverty_level]
      stat_year = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if stat_type == "Percent" && district == "ACADEMY 20" && poverty == "Eligible for Free or Reduced Lunch"
        hash = Hash[stat_year.to_i, (value.to_f * 1000).to_i / 1000.0]
        line = line.merge(hash)
      end
    end
    return line
  end

  def free_or_reduced_lunch_in_year(year)
    if year.to_s.length > 4
      return nil
    end
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
    stats = CSV.open "#{@path}/School-aged children in poverty.csv", headers: true, header_converters: :symbol
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
    stats = CSV.open "#{@path}/School-aged children in poverty.csv", headers: true, header_converters: :symbol
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
    stats = CSV.open "#{@path}/Title I students.csv", headers: true, header_converters: :symbol
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
    stats = CSV.open "#{@path}/Title I students.csv", headers: true, header_converters: :symbol
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
