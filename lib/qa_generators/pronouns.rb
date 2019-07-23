require_relative './qa_generator.rb'

class Pronouns < QAGenerator
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

  def ask_question(prompt)
  end

  def get_qna()
  end
end
