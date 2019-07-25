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
  end

  private
  def print_hint(article)
    generator = QnaGeneratorFactory.create(article)
    generator.print_hint
  end

  public

  desc "hint", ""

  def hint
    article = @prompt.enum_select("Select an article type?", @german_data.article_types)
    print_hint(article)
  end

  desc "test", ""

  def test(auto = false)
    article = nil
    if (article.nil?)
      article = @prompt.enum_select("which type do you want to study?", @german_data.article_types)
    end

    generator = QnaGeneratorFactory.create(article)
    generator.ask_question(@prompt)

    cnt = 0
    while (1)
      cnt += 1
      qna = generator.get_qna()
      question = "Q#{cnt}. #{qna[:question]} (enter:next, q:quit, h:hint)"
      answer = " => A#{cnt}. #{qna[:answer]}"

      if (auto == false)
        result = @prompt.ask question
        puts answer

        feature = {
          "q" => lambda { exit },
          "h" => lambda { print_hint(article) },
        }[result]
        feature.call if !feature.nil?
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
