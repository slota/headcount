require 'csv'
require 'pry'
require_relative 'economic_profile'
require_relative 'statewide_testing'
require_relative 'enrollment'

class District

  attr_accessor :economic_profile, :statewide_testing, :enrollment, :name

  def initialize(name, data, path)
    @name = name
    @economic_profile  = EconomicProfile.new(data, path)
    @statewide_testing = StatewideTesting.new(data, path)
    @enrollment        = Enrollment.new(data, path)
  end

end
