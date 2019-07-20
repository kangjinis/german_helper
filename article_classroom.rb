#!/usr/bin/env ruby
require 'thor'
require "yaml"
require 'terminal-table'
require 'colorize'
require 'tty-prompt'

class GermanArticleStudy
	def initialize
		@doc = YAML.load_file './definite_article.yaml'
	end
	public
	def genders
		@doc['genders_for_definite']
	end
	def cases
		@doc['cases']
	end
	def nouns
		@doc['nouns']
	end
	def article_types
		@doc['article_types']
	end
	def definite_articles
		@doc['definite_articles']
	end
end

class CLI < Thor
	def initialize(*args)
		super
		@helper = GermanArticleStudy.new
	end

	desc "hint", ''
	def hint
		prompt 	= TTY::Prompt.new
		article = prompt.enum_select("Select an article type?", @helper.article_types)
		gender 	= prompt.enum_select("Select a gender?", @helper.genders.keys)
	    specific_article = @helper.send(article)
	    table 	= Terminal::Table.new :rows => specific_article[gender], :title=>"#{article}##{gender}".red
	    puts table
    end

	desc 'test', ''
	def test(article='', gender='', repeat_no=1)
		prompt = TTY::Prompt.new

		if(article == '') 
			article = prompt.enum_select("Select an article type?", @helper.article_types)
		end

		if(gender == '')
			gender = prompt.enum_select("Select a gender?", @helper.genders.keys.clone.insert(0, 'all'))
			gender = @helper.genders.keys.sample if gender == 'all'
		end

	    noun_pair = @helper.nouns[gender].sample
	    noun_ger = noun_pair.keys[0]
	    noun_kor = noun_pair[noun_ger]

	    case_pair = @helper.cases.sample
	    case_ger = case_pair.keys[0]
	    case_kor = case_pair[case_ger]

	    prompt.ask "#{repeat_no}. Question : 그 #{noun_kor}#{case_kor}?"

	    specific_article = @helper.send(article)
		puts "  => #{repeat_no}. Answer : #{specific_article[gender][case_ger].red} #{noun_ger}"
		puts '---------------------------------------------'

		test(article, gender, repeat_no+=1)
	end
end

CLI.start(ARGV)