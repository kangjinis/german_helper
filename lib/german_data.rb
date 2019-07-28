require "yaml"

class GermanData
  def initialize
    @doc = YAML::load_file(File.join(__dir__, "german_data.yaml"))
  end

  private

  def genders
    %w(masculine neutral feminine plural)
  end

  def genders_for_indefinite
    %w(masculine neutral feminine)
  end

  public

  def cases_dic
    @doc["cases_dic"]
  end

  def get_genders_by_article(article)
    if(article == 'indefinite_articles')
      return genders_for_indefinite
    end
    genders
  end

  def get_ko_article(article)
    {
      "indefinite_articles" => "한",
      "definite_articles" => "그",
    }[article]
  end

  def article_types
    @doc["article_types"]
  end

  def definite_articles
    @doc["definite_articles"]
  end

  def indefinite_articles
    @doc["indefinite_articles"]
  end

  def possessive_pronouns
    @doc["possessive_pronouns"]
  end

  def pronouns_dic
    @doc["pronouns_dic"]
  end

  def nouns_dic
    @doc["nouns_dic"]
  end

  def pronouns
    @doc["pronouns"]
  end

  def possessive_articles
    @doc["possessive_articles"]
  end
end
