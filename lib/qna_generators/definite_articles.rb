require_relative "./qna_generator.rb"

class DefiniteArticles < QnaGenerator
  public

  def get_hint
    table = Terminal::Table.new do |t|
      t.headings = @german_data.cases_dic.keys.insert(0, "")
      genders.each do |g|
        item = @data[g]
        t.add_row [g, item["nominativ"], item["akkusativ"], item["dativ"], item["genetiv"]]
      end
    end
    table
  end

  def ask_question(prompt)
    @selected_gender = prompt.enum_select("Select a gender?", genders.insert(0, "all"))
  end

  def get_qna()
    gender = @selected_gender == 'all' ? get_random_gender : @selected_gender
    noun = get_random_noun(gender)
    case_item = get_random_case

    {
      :question => "#{@german_data.get_ko_article(@type)} #{noun[:kor]}#{case_item[:kor]}?",
      :answer   => "#{@data[gender][case_item[:ger]].to_s.red} #{noun[:ger]}",
    }
  end
end