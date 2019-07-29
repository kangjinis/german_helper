require "require_all"
require_all "lib"
require_all "lib/qna_generators"

RSpec.describe QnaGenerator do 
    it 'should pick up a gender' do 
      expect(QnaGeneratorFactory.create('definite_articles'))
    end
    it 'plus 1' do 
      expect(1).to eq(1)
    end
end