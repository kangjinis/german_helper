class PossesivePronouns
  def initialize
    @type = "posessive_pronouns"
    @german_data = GermanData.new
  end

  public

  def print_hint
    questions = @german_data.possesive_pronouns
    table = Terminal::Table.new do |t|
      t.headings = %w(pronouns possesive_pronouns)
      questions.keys.each { |k|
        t.add_row [k, questions[k]]
      }
    end
    puts table
  end

  def ask_question(prompt)
  end

  def get_qna()
    questions = @german_data.possesive_pronouns
    question = questions.keys.sample
    answer = questions[question]
    {
      :question => "#{question}?",
      :answer => "#{answer}",
    }
  end
end
