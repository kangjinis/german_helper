#!/usr/bin/env ruby
require "thor"
require "terminal-table"
require "colorize"
require "tty-prompt"
require "./lib/german_data.rb"
require "./lib/types/type_factory.rb"

class GermanGrammarCLI < Thor
  def initialize(*args)
    super
    @german_data = GermanData.new
    @prompt = TTY::Prompt.new
  end

  public

  desc "hint", ""

  def hint
    article = @prompt.enum_select("Select an article type?", @german_data.article_types)
    specific_article = @german_data.send(article)
    type_instance = TypeFactory.create(article)
    type_instance.print_hint
  end

  desc "test", ""

  def test(auto = false)
    article = nil
    if (article.nil?)
      article = @prompt.enum_select("which type do you want to study?", @german_data.article_types)
    end

    qna_generator = TypeFactory.create(article)
    qna_generator.ask_question(@prompt)

    cnt = 0
    while (1)
      cnt += 1
      qna = qna_generator.get_qna()
      question = "Q#{cnt}. #{qna[:question]}"
      answer = " => A#{cnt}. #{qna[:answer]}"

      if (auto == false)
        result = @prompt.ask question
        puts answer
        if (result == "q")
          exit
        end
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
