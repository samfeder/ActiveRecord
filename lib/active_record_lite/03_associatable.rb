require_relative '02_searchable'
require 'active_support/inflector'

# Phase IVa
class AssocOptions
<<<<<<< HEAD

=======
>>>>>>> 0cc231f222cf23d402157704302f6bf37b1944cb
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )
<<<<<<< HEAD
  #has_many(
  #:human,
  #:foreign_key => :human_id,
  #:class_name => "Human",
  #:primary_key => :id)
  #
  #
=======

>>>>>>> 0cc231f222cf23d402157704302f6bf37b1944cb
  def model_class
    # ...
  end

  def table_name
    # ...
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    # ...
  end
end

<<<<<<< HEAD



=======
>>>>>>> 0cc231f222cf23d402157704302f6bf37b1944cb
class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    # ...
  end
end

module Associatable
  # Phase IVb
  def belongs_to(name, options = {})
    # ...
  end

  def has_many(name, options = {})
    # ...
  end

  def assoc_options
    # Wait to implement this in Phase V. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
end
