class QnaGenerator
    private
    def underscore(str)
        str.gsub(/::/, '/').gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').tr("-", "_").downcase
    end

    def initialize()
        @german_data = GermanData.new
        @type = underscore(self.class.name)
        @data = @german_data.send(@type)
    end

    protected

    public
    def self.create(type_name)
        class_name = type_name.split('_').map{|x| x.capitalize}.join
        Object.const_get(class_name).new
    end
    def print_hint
        puts 'not implemented'
    end
    def ask_question(prompt)
    end
    def get_qna
    {
      :question => "Not implemented",
      :answer => "Not implemented",
    }
    end
end