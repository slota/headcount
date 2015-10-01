require 'csv'
require 'pry'
require 'district'

class DistrictRepository

  def self.from_csv(path)

    data = (CSV.open "#{path}/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol).map(&:to_h)
    district_data = data.group_by do |district|
      district.fetch(:location)
    end
    DistrictRepository.new(district_data, path)
  end

  def initialize(districts_data, path)
    @districts_by_name = clean_up_districts(districts_data, path)
  end

  def clean_up_districts(districts_data, path)
    districts_data.map { |location, district_data|
      [location.upcase, District.new(location.upcase, district_data, path)]
    }.to_h
  end

  def find_by_name(name)
    if @districts_by_name.keys.include?(name.upcase) == false
      return nil
    end
    @districts_by_name.fetch(name.upcase)
  end

  def find_all_matching(name)
    @districts_by_name.select{|dist, val|
      if dist.include?(name.upcase)
        val
      end
    }.values.to_a
  end
end
