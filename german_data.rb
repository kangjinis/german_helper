require 'yaml'

class GermanData
	def initialize
		@doc = YAML.load_file './definite_article.yaml'
	end
	public
	def get_random_noun(gender)
		noun_pair = @doc['nouns'][gender].sample
		return noun_pair.keys[0], noun_pair[noun_pair.keys[0]]
	end
	def genders
		%w(masculine neutral feminine plural)
	end
	def genders_for_indefinite
		%w(masculine neutral feminine)
	end
	def genders_with_all
		genders.insert(0, 'all')
	end
	def genders_for_indefinite_with_all
		genders = genders_for_indefinite.insert(0, 'all')
		genders.delete('plural')
		genders
	end
	def cases
		@doc['cases']
	end
	def get_random_case
		case_pair = cases.sample
		return case_pair.keys[0], case_pair[case_pair.keys[0]]
	end
	def article_types
		%w(definite_articles indefinite_articles)
	end
	def definite_articles
		@doc['definite_articles']
	end
	def indefinite_articles
		@doc['indefinite_articles']
	end
end