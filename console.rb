require('pry')
require_relative('models/property')

property1 = Property.new({
  'address' => "64 Zoo Lane",
  'value' => 230000,
  'number_of_bedrooms' => 3,
  'year_built' => 1900
  })

  property2 = Property.new({
    'address' => "65 Zoo Lane",
    'value' => 200,
    'number_of_bedrooms' => 7,
    'year_built' => 1920
    })

property1.save()

  binding.pry
  nil
