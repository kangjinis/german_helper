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
    noun_pair = @doc["nouns_dic"][gender].sample
    return noun_pair.keys[0], noun_pair[noun_pair.keys[0]]
  end

  def get_random_case
    case_ger = cases_dic.keys.sample
    case_kor = cases_dic[case_ger]
    return case_ger, case_kor
  end

  def get_random_pronoun
    pronoun_ger = pronouns_dic.keys.sample
    pronoun_kor = pronouns_dic[pronoun_ger]
    return pronoun_ger, pronoun_kor
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

  def possesive_pronouns
    @doc["possesive_pronouns"]
  end

  def pronouns_dic
    @doc["pronouns_dic"]
  end

  def pronouns
    @doc["pronouns"]
  end
end
