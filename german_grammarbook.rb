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
	def get_definite_article_qna(article, gender)
		if gender == 'all' 
			gender = @german_data.genders.sample
		end

	    noun_pair = @german_data.nouns[gender].sample
	    noun_ger = noun_pair.keys[0]
	    noun_kor = noun_pair[noun_ger]

	    case_pair = @german_data.cases.sample
	    case_ger = case_pair.keys[0]
	    case_kor = case_pair[case_ger]

		{
			:question	=> "그 #{noun_kor}#{case_kor}?",
			:answer		=> "#{@german_data.definite_articles[gender][case_ger]} #{noun_ger}"
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
	def test(article='', gender='', repeat_no=1)
		if(article == '') 
			article = @prompt.enum_select("which type do you want to study?", @german_data.article_types)
		end
		if(gender == '')
			gender = @prompt.enum_select("Select a gender?", @german_data.genders.clone.insert(0, 'all'))
		end
		puts '---------------------------------------'

		qna = get_definite_article_qna(article, gender)
		question = "Q#{repeat_no}. #{qna[:question]}"
		@prompt.ask question
		answer = " => A#{repeat_no}. #{qna[:answer]}"
		puts answer

		test(article, gender, repeat_no + 1)
	end
end

GermanGrammarCLI.start(ARGV)