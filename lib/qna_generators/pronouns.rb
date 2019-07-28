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
    pronoun = get_random_pronoun
    case_item = get_random_case
    {
      :question => "#{pronoun[:kor]}#{case_item[:kor]}?",
      :answer => "#{@data[pronoun[:ger]][case_item[:ger]].red}",
    }
  end
end
