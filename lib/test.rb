
  path       = File.expand_path("../data", __dir__)

data = (CSV.open "#{path}/Students qualifying for free or reduced price lunch.csv", headers: true, header_converters: :symbol).map(&:to_h)
district_hash = data.group_by do |district|
  district.fetch(:location)
end
