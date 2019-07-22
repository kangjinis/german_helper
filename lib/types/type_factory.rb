require_relative "./definite_articles.rb"
require_relative "./indefinite_articles.rb"
require_relative "./possesive_pronouns.rb"

class TypeFactory
  def get_instance(type)
    {
      "definite_articles" => DefiniteArticles.new,
      "indefinite_articles" => IndefiniteArticles.new,
      "possesive_pronouns" => PossesivePronouns.new,
    }[type]
  end
end
