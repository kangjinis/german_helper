require_relative './qa_generator.rb'

class PossesivePronouns < QAGenerator
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
