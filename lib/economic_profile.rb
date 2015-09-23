require 'pry'
require 'csv'

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
    @economic_profile  = EconomicProfile.new(data[:economic_profile])
    @statewide_testing = StatewideTesting.new(data[:statewide_testing])
    @enrollment        = Enrollment.new(data[:enrollment])
  end

  def economic_profile
  end

  def statewide_testing
  end

  def enrollment
  end
end

class EconomicProfile

  def initialize(data)
    @data = data
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

end
#   def from_csv(path)
#     contents = CSV.open(path), headers: true, header_converters: :symbol
#     contents
#   end
# end
# path       = File.expand_path("../data", __dir__)
# repository = DistrictRepository.from_csv(path)
