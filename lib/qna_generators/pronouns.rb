require_relative "./qna_generator.rb"

class Pronouns < QnaGenerator
  public

  def print_hint
    table = Terminal::Table.new do |t|
      t.headings = @german_data.cases_dic.keys
      @german_data.pronouns.keys.each do |pronoun|
        item = @data[pronoun]
        t.add_row [pronoun, item["akkusativ"], item["dativ"], item["genetiv"]]
      end
    end
    puts table
  end

  def get_qna()
    pronoun_ger, pronoun_kor = @german_data.get_random_pronoun
    case_ger, case_kor = @german_data.get_random_case

    {
      :question => "#{pronoun_kor}#{case_kor}?",
      :answer => "#{@data[pronoun_ger][case_ger].red}",
    }
  end
end
