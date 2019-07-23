require_relative './qa_generator.rb'

class PossesivePronouns < QAGenerator
  public

  def print_hint
    questions = @data
    table = Terminal::Table.new do |t|
      t.headings = %w(pronouns possesive_pronouns)
      questions.keys.each { |k|
        t.add_row [k, questions[k]]
      }
    end
    puts table
  end

  def get_qna()
    questions = @data
    question = questions.keys.sample
    answer = questions[question]
    {
      :question => "#{question}?",
      :answer => "#{answer}",
    }
  end
end
