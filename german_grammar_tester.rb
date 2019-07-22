#!/usr/bin/env ruby
require "thor"
require "terminal-table"
require "colorize"
require "tty-prompt"
require "./german_data.rb"

class GermanGrammarCLI < Thor
  def initialize(*args)
    super
    @german_data = GermanData.new
    @prompt = TTY::Prompt.new
  end

  private

  def get_article_qna(article, gender)
    if gender == "all"
      gender = @german_data.get_genders_by_article(article).sample
    end

    noun_ger, noun_kor = @german_data.get_random_noun(gender)
    case_ger, case_kor = @german_data.get_random_case

    {
      :question => "#{@german_data.get_ko_article(article)} #{noun_kor}#{case_kor}?",
      :answer => "#{@german_data.send(article)[gender][case_ger].red} #{noun_ger}",
    }
  end

  public

  desc "hint", ""

  def hint
    article = @prompt.enum_select("Select an article type?", @german_data.article_types)
    specific_article = @german_data.send(article)

    table = Terminal::Table.new do |t|
      t.headings = @german_data.cases.keys.insert(0, '')
      genders = @german_data.get_genders_by_article(article)
      genders.each do |g|
        item = specific_article[g]
        t.add_row [g,item['nominativ'],item['akkusativ'],item['dativ'], item['genetiv']]
      end
    end

    puts table
  end

  desc "test", ""

  def test(auto = false)
    article = nil; gender = nil
    if (article.nil?)
      article = @prompt.enum_select("which type do you want to study?", @german_data.article_types)
    end
    if (gender.nil?)
      genders = @german_data.get_genders_by_article(article).insert(0, "all")
      gender = @prompt.enum_select("Select a gender?", genders)
    end
    puts "---------------------------------------"

    cnt = 0
    while (1)
      cnt += 1
      qna = get_article_qna(article, gender)
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
