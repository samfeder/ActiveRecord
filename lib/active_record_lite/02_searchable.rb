require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
<<<<<<< HEAD
    searchables = "#{params.keys.map { |key| key.to_s}.join(" = ? AND ")} = ?"
    query = DBConnection.execute(<<-SQL, *(params.values))
    SELECT
      *
    FROM
      #{self.table_name}
    WHERE
      #{searchables}
    SQL
    parse_all(query)
=======
    # ...
>>>>>>> 0cc231f222cf23d402157704302f6bf37b1944cb
  end
end

class SQLObject
<<<<<<< HEAD
  extend Searchable
end

p Cat.where(:id=>1, :name=>"Breakfast")
=======
  # Mixin Searchable here...
end
>>>>>>> 0cc231f222cf23d402157704302f6bf37b1944cb
