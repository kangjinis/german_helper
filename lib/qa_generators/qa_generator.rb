class QAGenerator
    private
    def underscore(str)
        str.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
    end

    def initialize()
        @german_data = GermanData.new
        @type = underscore(self.class.name)
    end
    
    public
    def print_hint
        puts 'not implemented'
    end
    def ask_question
    end
    def get_qna
    {
      :question => "Not implemented",
      :answer => "Not implemented",
    }
    end
end