require('pg')

class Property

  attr_reader :id
  attr_accessor :address, :value, :number_of_bedrooms, :year_built

    def initialize ( options )
      @id = options['id'].to_i if options['id']
      @address = options['address']
      @value = options['value'].to_i
      @number_of_bedrooms = options['number_of_bedrooms'].to_i
      @year_built = options['year_built'].to_i
  end

  def save()
  # In DB is a database connection
  db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
  sql =
    "INSERT INTO propertys_table (
    address,
    value,
    number_of_bedrooms,
    year_built
    ) VALUES ($1, $2, $3, $4) RETURNING id;
    "
      values = [@address, @value, @number_of_bedrooms, @year_built]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i()
      db.close()
  end

  

end
