class QnaGenerator
  private

  def underscore(str)
    str.gsub(/::/, "/").gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').gsub(/([a-z\d])([A-Z])/, '\1_\2').tr("-", "_").downcase
  end

  def initialize()
    @german_data = GermanData.new
    @type = underscore(self.class.name)
    @data = @german_data.send(@type)
  end

  protected

  def genders
    @german_data.get_genders_by_article(@type)
  end
  def get_random_gender
    @german_data.get_genders_by_article(@type).sample
  end
  def get_random_pronoun
    pronouns = @german_data.pronouns_dic
    pronoun_ger = pronouns.keys.sample
    {
      ger: pronoun_ger,
      kor: pronouns[pronoun_ger]
    }
  end
  def get_random_noun()
    nouns = @german_data.nouns_dic[get_random_gender]
    noun_ger = nouns.keys.sample
    {
      ger: noun_ger,
      kor: nouns[noun_ger]
    }
  end
  def get_random_case
    case_ger = @german_data.cases_dic.keys.sample
    case_kor = @german_data.cases_dic[case_ger]
    {
      ger: case_ger,
      kor: case_kor
    }
  end

  public

  def self.create(type_name)
    class_name = type_name.split("_").map { |x| x.capitalize }.join
    Object.const_get(class_name).new
  end

  def print_hint
    puts "not implemented"
  end

  def ask_question(prompt)
  end

  def get_qna
    {
      :question => "Not implemented",
      :answer => "Not implemented",
    }
  end
end
