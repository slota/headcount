require 'csv'
require 'pry'
require 'district'

class DistrictRepository

  def self.from_csv(path)

    data = (CSV.open "#{path}/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol).map(&:to_h)
    district_data = data.group_by do |district|
      district.fetch(:location)
    end
    # district_data = data.map { |row| [row.fetch(:location).upcase, {}]}.to_h
    DistrictRepository.new(district_data, path)
  end

  # def initialize(districts_data = self.from_csv)
  #   @districts_by_name = districts_data.map { |name, district_data|
  #     [name.upcase, District.new(name, district_data)]
  #   }.to_h
  # end

  def initialize(districts_data, path)
    @districts_by_name = clean_up_districts(districts_data, path)
  end

  def clean_up_districts(districts_data, path)
    districts_data.map { |location, district_data|
      [location.upcase, District.new(location.upcase, district_data, path)]
    }.to_h
  end

  def find_by_name(name)
    # @save_name = name
    @districts_by_name.fetch(name.upcase)
  end

  def find_all_matching(name)
  end

end
