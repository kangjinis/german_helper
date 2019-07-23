require 'require_all'
require_all 'lib/qa_generators'

class QAGeneratorFactory
  def self.create(type_name)
    class_name = type_name.split('_').map{|x| x.capitalize}.join
    Object.const_get(class_name).new
  end
end