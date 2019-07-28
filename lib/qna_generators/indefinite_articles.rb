require_relative "./qna_generator.rb"

class IndefiniteArticles < QnaGenerator
  public

  def print_hint
    table = Terminal::Table.new do |t|
      t.headings = @german_data.cases_dic.keys.insert(0, "")
      genders = @german_data.get_genders_by_article(@type)
      genders.each do |gender|
        item = @data[gender]
        t.add_row [gender, item["nominativ"], item["akkusativ"], item["dativ"], item["genetiv"]]
      end
    end
    puts table
  end

  def ask_question(prompt)
    genders = @german_data.get_genders_by_article(@type).insert(0, "all")
    @selected_gender = prompt.enum_select("Select a gender?", genders)
  end

  def get_qna()
    gender = @german_data.get_genders_by_article(@type).sample if @selected_gender == 'all'
    noun = get_random_noun
    case_item = get_random_case

    {
      :question => "#{@german_data.get_ko_article(@type)} #{noun[:kor]}#{case_item[:kor]}?",
      :answer => "#{@data[gender][case_item[:ger]].red} #{noun[:ger]}",
    }
  end
end
