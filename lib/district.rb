require 'csv'
require 'pry'
require 'economic_profile'

class District

  attr_reader :data

  def initialize(data)
    @data = data
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
    @economic_profile = EconomicProfile.new(name)
  end


end
