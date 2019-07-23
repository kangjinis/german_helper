require_relative './qna_generator.rb'

class DefiniteArticles < QnaGenerator

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
    @gender = prompt.enum_select("Select a gender?", genders)
  end

  def get_qna()
    if @gender == "all"
      @gender = @german_data.get_genders_by_article(@type).sample
    end

    noun_ger, noun_kor = @german_data.get_random_noun(@gender)
    case_ger, case_kor = @german_data.get_random_case

    {
      :question => "#{@german_data.get_ko_article(@type)} #{noun_kor}#{case_kor}?",
      :answer => "#{@data[@gender][case_ger].red} #{noun_ger}",
    }
  end
end
