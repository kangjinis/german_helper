require "yaml"

class GermanData
  def initialize
    @doc = YAML.load_file "./german_data.yaml"
  end

  private

  def genders
    %w(masculine neutral feminine plural)
  end

  def genders_for_indefinite
    %w(masculine neutral feminine)
  end

  def cases
    @doc["cases"]
  end

  public

  def get_genders_by_article(article)
    {
      "indefinite_articles" => genders_for_indefinite,
      "definite_articles" => genders,
    }[article]
  end

  def get_ko_article(article)
    {
      "indefinite_articles" => "한",
      "definite_articles" => "그",
    }[article]
  end

  def get_random_noun(gender)
    noun_pair = @doc["nouns"][gender].sample
    return noun_pair.keys[0], noun_pair[noun_pair.keys[0]]
  end

  def get_random_case
    case_pair = cases.sample
    return case_pair.keys[0], case_pair[case_pair.keys[0]]
  end

  def article_types
    %w(definite_articles indefinite_articles)
  end

  def definite_articles
    @doc["definite_articles"]
  end

  def indefinite_articles
    @doc["indefinite_articles"]
  end
end
