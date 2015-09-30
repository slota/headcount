require 'csv'
require 'pry'
require_relative 'economic_profile'
require_relative 'statewide_testing'
require_relative 'enrollment'

class District

  attr_accessor :economic_profile, :statewide_testing, :enrollment, :name

  def initialize(name, data)
    @name = name
    @economic_profile  = EconomicProfile.new(data)
    @statewide_testing = StatewideTesting.new(data)
    @enrollment        = Enrollment.new(data)
  end

end
