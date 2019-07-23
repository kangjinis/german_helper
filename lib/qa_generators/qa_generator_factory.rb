require 'require_all'
require_all 'lib/qa_generators'

class QAGeneratorFactory
  def self.create(type_name)
    splited_type_names = type_name.split('_')
    class_name = splited_type_names[0].capitalize + splited_type_names[1].capitalize
    Object.const_get(class_name).new
  end
end