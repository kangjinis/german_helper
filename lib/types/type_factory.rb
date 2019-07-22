require_relative "./definite_articles.rb"
require_relative "./indefinite_articles.rb"

class TypeFactory
  def get_instance(type)
    {
      "definite_articles" => DefiniteArticles.new,
      "indefinite_articles" => IndefiniteArticles.new,
    }[type]
  end
end
