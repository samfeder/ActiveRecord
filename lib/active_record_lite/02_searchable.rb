require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
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
  end
end

class SQLObject
  extend Searchable
end

p Cat.where(:id=>1, :name=>"Breakfast")
  # Mixin Searchable here...

