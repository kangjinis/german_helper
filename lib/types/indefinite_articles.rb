class IndefiniteArticles
  def initialize
    @type = "indefinite_articles"
    @german_data = GermanData.new
  end

  public

  def print_hint
    specific_article = @german_data.send(@type)

    table = Terminal::Table.new do |t|
      t.headings = @german_data.cases.keys.insert(0, "")
      genders = @german_data.get_genders_by_article(@type)
      genders.each do |g|
        item = specific_article[g]
        t.add_row [g, item["nominativ"], item["akkusativ"], item["dativ"], item["genetiv"]]
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
      :answer => "#{@german_data.send(@type)[@gender][case_ger].red} #{noun_ger}",
    }
  end
end
