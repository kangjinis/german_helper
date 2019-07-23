require 'require_all'
require_all 'lib/qa_generators'

class QAGeneratorFactory
  def self.create(type_name)
    splited_type_names = type_name.split('_')
    class_name = nil
    if(splited_type_names.size > 1)
      class_name = splited_type_names[0].capitalize + splited_type_names[1].capitalize
    else
      class_name = splited_type_names[0].capitalize
    end
    Object.const_get(class_name).new
  end
end