require 'yaml'

class GermanData
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