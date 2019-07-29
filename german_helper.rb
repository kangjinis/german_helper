#!/usr/bin/env ruby
require "thor"
require "terminal-table"
require "colorize"
require "tty-prompt"
require "./lib/german_data.rb"
require "./lib/qna_generators/qna_generator_factory.rb"

class GermanGrammarCLI < Thor
  def initialize(*args)
    super
    @german_data = GermanData.new
    @prompt = TTY::Prompt.new
    @generator = nil
  end

  private
  def print_hint(article)
    @generator = QnaGeneratorFactory.create(article) if @generator == nil
    @generator.print_hint
  end

  public

  desc "hint", ""

  def hint
    article = @prompt.enum_select("Select an article type?", @german_data.article_types)
    print_hint(article)
  end

  desc "test", ""

  def test(auto = false)
    article = @prompt.enum_select("which type do you want to study?", @german_data.article_types)
    @generator = QnaGeneratorFactory.create(article)
    @generator.ask_question(@prompt)

    dunno = []
    cnt = 0
    while (1)
      cnt += 1
      qna = @generator.get_qna()
      question = "Q#{cnt}. #{qna[:question]} (enter:show answer, q:quit, h:hint)"
      answer = " => A#{cnt}. #{qna[:answer]}"

      if (auto == false)
        result = @prompt.ask question
        features = {
          "q" => lambda { 
            puts "Answer status : #{cnt-dunno.size}/#{cnt}" 
            puts "Please check below items what you checked : " if dunno.size > 0
            dunno.uniq.each_with_index{|qna, index| 
              puts "  #{index +1}. question : #{qna[:question]}, answer : #{qna[:answer]}"
            }
            print_hint(article)
            exit 
          },
          "h" => lambda { 
            print_hint(article) 
          },
        }[result]
        features.call if !features.nil?

        second_result = @prompt.ask(answer + " (correct:enter, wrong:x, hint:h)")
        dunno.push qna if(second_result == 'x')
	print_hint(article) if second_result == 'h'
      else
        puts question
        sleep(3)
        puts answer
        sleep(1)
      end
    end
  end
end

GermanGrammarCLI.start(ARGV)
