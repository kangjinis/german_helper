require "require_all"
require_all "lib/qna_generators"

class QnaGeneratorFactory
  def self.create(type_name)
    class_name = type_name.split("_").map { |x| x.capitalize }.join
    Object.const_get(class_name).new
  end
end
