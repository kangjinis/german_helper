require_relative "./qna_generator.rb"

class PossessiveArticles < QnaGenerator
  public

  def print_hint
    table = Terminal::Table.new do |t|
      t.headings = genders.insert(0, "")
      @german_data.pronouns_dic.keys.each do |pronoun|
        item = @data[pronoun]
        t.add_row [pronoun, item["masculine"], item["neutral"], item["feminine"], item["plural"]]
      end
    end
    puts table
  end

  def get_qna()
    pronoun = get_random_pronoun
    gender = get_random_gender
    noun = get_random_noun(gender)
    {
      :question => "#{pronoun[:kor]}의 #{noun[:kor]}?",
      :answer => "#{@data[pronoun[:ger]][gender]} #{noun[:ger]}"
    }
  end
end
