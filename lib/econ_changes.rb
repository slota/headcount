class Enrollment

  def initialize(data)
    @data = data
  end

  def dropout_rate_in_year(year_input)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = ""
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if year == year_input && category == "All Students"
        line << value
        return line.to_f
      end
    end
  end

  def dropout_rate_by_gender_in_year(year_input)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"

        if year == year_input && category == "Female Students" || year == year_input && category == "Male Students"
          if category == "Female Students"
            category = category[0..5].downcase
          elsif
            category == "Male Students"
              category = category [0..3].downcase
          end
          hash = Hash[category, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def dropout_rate_by_race_in_year(year_input)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        if year == year_input && category == "Asian Students" || year == year_input && category == "Black Students" || year == year_input && category == "Hispanic Students" || year == year_input && category == "Native Hawaiian or Other Pacific Islander" || year == year_input && category == "Native American Students" || year == year_input && category == "Two or More Races" || year == year_input && category == "White Students"
          if category == "Asian Students"
            category = category[0..4].downcase
          elsif
            category == "Black Students"
              category = category[0..4].downcase
          elsif
            category == "Native Hawaiian or Other Pacific Islander"
              category = category[25..40].downcase
          elsif
            category == "Hispanic Students"
              category = category[0..7].downcase
          elsif
            category == "Native American Students"
              category = category[0..14].downcase
          elsif
            category == "Two or More Races"
              category = category[0..10].downcase
          elsif
            category == "White Students"
              category = category[0..4].downcase
          end
          hash = Hash[category, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def dropout_rate_for_race_or_ethnicity(race)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race = race.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        if race == "asian"
          category_check = "Asian Students"
        elsif
          race == "black"
            category_check = "Black Students"
        elsif
          race == "pacific_islander"
            category_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race == "hispanic"
            category_check = "Hispanic Students"
        elsif
          race == "native_american"
            category_check = "Native American Students"
        elsif
          race == "two_or_more"
            category_check = "Two or More Races"
        elsif
          race == "white"
            category_check = "White Students"
        elsif
          line = "UnknownRaceError"
          return line
        end
        if category_check == category
          hash = Hash[year, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def dropout_rate_for_race_or_ethnicity_in_year(race, year_input)
    data = CSV.open "../headcount/data/Dropout rates by race and ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race = race.to_s
    year_input = year_input.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:category]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        if race == "asian"
          category_check = "Asian Students"
        elsif
          race == "black"
            category_check = "Black Students"
        elsif
          race == "pacific_islander"
            category_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race == "hispanic"
            category_check = "Hispanic Students"
        elsif
          race == "native_american"
            category_check = "Native American Students"
        elsif
          race == "two_or_more"
            category_check = "Two or More Races"
        elsif
          race == "white"
            category_check = "White Students"
        elsif
          line = "UnknownRaceError"
          return line
        end
        if category_check == category && year_input == year

          hash = Hash[year, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end

  def graduation_rate_by_year
    data = CSV.open "../headcount/data/High school graduation rates.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def graduation_rate_in_year(year_input)
    data = CSV.open "../headcount/data/High school graduation rates.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]

      if district == "Colorado" && year_input == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def kindergarten_participation_by_year
    data = CSV.open "../headcount/data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def kindergarten_participation_in_year(year_input)
    data = CSV.open "../headcount/data/Kindergartners in full-day program.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]

      if district == "Colorado" && year_input == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def online_participation_by_year
    data = CSV.open "../headcount/data/Online pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def online_participation_in_year(input_year)
    data = CSV.open "../headcount/data/Online pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def participation_by_year
    data = CSV.open "../headcount/data/Pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def participation_in_year(input_year)
    data = CSV.open "../headcount/data/Pupil enrollment.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def participation_by_race_or_ethnicity(race_input)
    data = CSV.open "../headcount/data/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    race_input = race_input.to_s
    data.each do |columns|
      district  = columns[:location]
      race      = columns[:race]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        if race_input == "asian"
          race_check = "Asian Students"
        elsif
          race_input == "black"
            race_check = "Black Students"
        elsif
          race_input == "pacific_islander"
            race_check = "Native Hawaiian or Other Pacific Islander"
        elsif
          race_input == "hispanic"
            race_check = "Hispanic Students"
        elsif
          race_input == "native_american"
            race_check = "Native American Students"
        elsif
          race_input == "two_or_more"
            race_check = "Two or More race_inputs"
        elsif
          race_input == "white"
            race_check = "White Students"
        elsif
          line = "UnknownRaceError"
          return line
        end
        if race_check == race
          hash = Hash[year, value]
          line = line.merge(hash)
        end
      end
    end
    return line
  end
  #
  def participation_by_race_or_ethnicity_in_year(year_input)
    data = CSV.open "../headcount/data/Pupil enrollment by race_ethnicity.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    year_input = year_input.to_s
    data.each do |columns|
      district  = columns[:location]
      category  = columns[:race]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && year == year_input
        if category == "Asian Students"
          category = category[0..4].downcase
        elsif
          category == "Black Students"
            category = category[0..4].downcase
        elsif
          category == "Native Hawaiian or Other Pacific Islander"
            category = category[25..40].downcase
        elsif
          category == "Hispanic Students"
            category = category[0..7].downcase
        elsif
          category == "American Indian Students"
            category = category[0..14].downcase
        elsif
          category == "Two or more races"
            category = category[0..10].downcase
        elsif
          category == "White Students"
            category = category[0..4].downcase
        end
        hash = Hash[category, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def special_education_by_year
    data = CSV.open "../headcount/data/Special education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def special_education_in_year(input_year)
    data = CSV.open "../headcount/data/Special education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end

  def remediation_by_year
    data = CSV.open "../headcount/data/Remediation in higher education.csv", headers: true, header_converters: :symbol

    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado"
        hash = Hash[year, value]
        line = line.merge(hash)
      end
    end
    return line
  end

  def remediation_in_year(input_year)
    data = CSV.open "../headcount/data/Remediation in higher education.csv", headers: true, header_converters: :symbol
    line = {}
    hash = {}
    data.each do |columns|
      district  = columns[:location]
      year      = columns[:timeframe]
      stat_type = columns[:dataformat]
      value     = columns[:data]
      if district == "Colorado" && input_year == year
        line = value
      end
    end
    return line.to_f.round(3)
  end
end

def test_dropout_rate_for_race_or_ethnicity
  expected = {"2011"=>"0.017", "2012"=>"0.016"}
  assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_for_race_or_ethnicity(:asian)
end

def test_dropout_rate_for_race_or_ethnicity_in_year
  expected = {"2012"=>"0.016"}
  assert_equal expected, Enrollment.new({lunch_thing: 123}).dropout_rate_for_race_or_ethnicity_in_year(:asian, 2012)
end


  def test_participation_by_race_or_ethnicity
    expected = {"2007"=>"0.034", "2008"=>"0.036", "2009"=>"0.037", "2010"=>"0.03", "2011"=>"0.03105", "2012"=>"27266", "2013"=>"26895", "2014"=>"27297"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).participation_by_race_or_ethnicity(:asian)
  end

  def test_participation_by_race_or_ethnicity_in_year
    expected = {"american indian"=>"6716", "asian"=>"27266", "black"=>"40496", "hispanic"=>"278619", "pacific islander"=>"1860", "two or more"=>"28238", "white"=>"480366", "Total"=>"863561"}
    assert_equal expected, Enrollment.new({lunch_thing: 123}).participation_by_race_or_ethnicity_in_year(2012)
  end
