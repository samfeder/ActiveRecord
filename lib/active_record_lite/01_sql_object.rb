require_relative 'db_connection'
require 'active_support/inflector'
#NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
#    of this project. It was only a warm up.

class SQLObject
  def self.columns

    return @columns if @columns

    query = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
      #{self.table_name}
    SQL

    @columns = query.first.map { |col| col.to_sym}
  end

  def self.finalize!
    return if @finalized

    columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end
    end

    columns.each do |col|
      define_method("#{col}=") do |val|
        self.attributes[col] = val
      end
    end

    @finalized = true
  end



  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.downcase.pluralize
  end

  def self.all

    query = DBConnection.execute(<<-SQL)
      SELECT
      #{self.table_name}.*
      FROM
      #{self.table_name}
    SQL

    self.parse_all(query)
  end

  def self.parse_all(results)
    cats =[]
    results.each do |hash|
      # my lord... Takes each key of the hash and makes it a sym...
      # tempted to just monkey patch the Hash class.
      cats << self.new(Hash[hash.map {|key,value| [key.to_sym, value]}])
    end
    cats
  end

  def self.find(id)
    query = DBConnection.execute(<<-SQL, id)
      SELECT
      #{self.table_name}.*
      FROM
      #{self.table_name}
      WHERE
      id = ?
    SQL
    self.parse_all(query).first
  end

  def attributes
    @attributes ||= {}
  end

  def insert
    cols = attributes.keys
    question_marks = ("?" * cols.length).split("").join(",")
    cols = cols.join(", ").chomp

    DBConnection.execute(<<-SQL, (attribute_values))
      INSERT INTO
        #{self.class.table_name} (#{cols})
      VALUES
        (#{question_marks})
    SQL

    self.id = DBConnection.instance.last_insert_row_id

  end

  def initialize(params = {})
    self.class.finalize!

    params.each do |attr_name, value|
      self.class.columns
      raise "unknown attribute '#{attr_name.to_sym}'" unless self.class.columns.include?(attr_name)
      self.send(:"#{attr_name}=", value)
    end

  end

  def save
    # ...
  end

  def update
    DBConnection.execute(<<-SQL, (attribute_values))
      UPDATE
        #{self.class.table_name}
      SET
        (#{question_marks})
      WHERE
        id = ?
    SQL
  end

  def attribute_values
    self.attributes.values
  end
end

class Cat < SQLObject
  finalize!
end

class Human < SQLObject
  finalize!
end

#Pluralize changing humans to HUMEN...COME ON MAN!

Human.find(2)
