require 'csv'
require 'pry'
require 'district'
require 'economic_profile'

class DistrictRepository

  attr_reader :data

  def initialize(data)
    @district = District.new(data)
    binding.pry
  end

  def self.from_csv(path)
    data = CSV.open "data", headers: true
    # sqfforpl_contents.each do |row|
    #   puts row
    # end
    # @find_by_name = find_by_name(name)
    DistrictRepository.new(data)
  end

  def find_by_name(name)

    @district.find_by_name(name)
  end


end
