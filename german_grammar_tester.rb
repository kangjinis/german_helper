#!/usr/bin/env ruby
require 'thor'
require 'terminal-table'
require 'colorize'
require 'tty-prompt'
require './german_data.rb'

class GermanGrammarCLI < Thor
	def initialize(*args)
		super
		@german_data = GermanData.new
		@prompt = TTY::Prompt.new
	end

	private
	def get_ko_article(article)
		case article
		when 'indefinite_article'
			return '한'
		when 'definite_article'
			return '그'
		end
	end
	def get_article_qna(article, gender)
		if gender == 'all' 
			genders = nil
			case article
			when 'indefinite_articles'
				genders = @german_data.genders_for_indefinite
			when 'definite_articles'
				genders = @german_data.genders
			end
			gender = genders.sample
		end

		noun_ger, noun_kor = @german_data.get_random_noun(gender)
		case_ger, case_kor = @german_data.get_random_case

		{
			:question	=> "#{get_ko_article(article)} #{noun_kor}#{case_kor}?",
			:answer		=> "#{@german_data.send(article)[gender][case_ger].red} #{noun_ger}"
		}
	end

	public
	desc "hint", ''
	def hint
		article = @prompt.enum_select("Select an article type?", @german_data.article_types)
		gender 	= @prompt.enum_select("Select a gender?", @german_data.genders)
	    specific_article = @german_data.send(article)
	    table 	= Terminal::Table.new :rows => specific_article[gender], :title=>"#{article}##{gender}".red
	    puts table
    end

	desc 'test', ''
	def test(auto=false)
		article = nil; gender = nil;
		if(article.nil?) 
			article = @prompt.enum_select("which type do you want to study?", @german_data.article_types)
		end
		if(gender.nil?)
			genders = article == 'definite_articles' ? @german_data.genders_with_all : @german_data.genders_for_indefinite_with_all
			gender = @prompt.enum_select("Select a gender?", genders) 
		end
		puts '---------------------------------------'

		cnt = 0
		while(1) do 
			cnt += 1
			qna = get_article_qna(article, gender)
			question = "Q#{cnt}. #{qna[:question]}"
			answer = " => A#{cnt}. #{qna[:answer]}"

			if(auto == false)
				@prompt.ask question
				puts answer
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