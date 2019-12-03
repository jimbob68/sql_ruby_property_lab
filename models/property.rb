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

  def Property.all()
  db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
  sql = "SELECT * from propertys_table;"
  db.prepare("all", sql)
  property = db.exec_prepared("all")
  db.close()
  return property.map { |property_hash| Property.new(property_hash) }
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

  def update()
  db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
  sql =
    "UPDATE propertys_table set (
    address,
    value,
    number_of_bedrooms,
    year_built
    ) = (
      $1, $2, $3, $4
    ) WHERE id = $5;
    "
      values = [@address, @value, @number_of_bedrooms, @year_built, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
  end


  def delete()
      db = PG.connect({ dbname: 'property_tracker', host: 'localhost'})
      sql = "DELETE FROM propertys_table WHERE id = $1"
      values = [@id]
      db.prepare("delete_one", sql)
      db.exec_prepared("delete_one", values)
      db.close
    end

    def Property.delete_all()
        db = PG.connect({ dbname: 'property_tracker', host: 'localhost' })
        sql = "DELETE FROM propertys_table"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end


end
