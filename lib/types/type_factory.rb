require 'require_all'
require_all 'lib/types'

class TypeFactory
  def self.create(type_name)
    splited_type_names = type_name.split('_')
    class_name = splited_type_names[0].capitalize + splited_type_names[1].capitalize
    klass = Object.const_get(class_name) 
    klass.new
  end
end
