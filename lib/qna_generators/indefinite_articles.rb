require_relative "./qna_generator.rb"

class IndefiniteArticles < QnaGenerator
  public

  def print_hint
    table = Terminal::Table.new do |t|
      t.headings = @german_data.cases_dic.keys.insert(0, "")
      genders.each do |gender|
        item = @data[gender]
        t.add_row [gender, item["nominativ"], item["akkusativ"], item["dativ"], item["genetiv"]]
      end
    end
    puts table
  end

  def ask_question(prompt)
    @selected_gender = prompt.enum_select("Select a gender?", genders.insert(0, "all"))
  end

  def get_qna()
    gender = get_random_gender
    noun = get_random_noun
    case_item = get_random_case

    {
      :question => "#{@german_data.get_ko_article(@type)} #{noun[:kor]}#{case_item[:kor]}?",
      :answer => "#{@data[gender][case_item[:ger]].red} #{noun[:ger]}",
    }
  end
end
