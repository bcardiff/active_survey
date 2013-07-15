module ActiveSurvey
  class Question
    attr_reader :name
    attr_accessor :text

    def initialize(name, text)
      @name = name
      @text = text
    end

    def type
      :text
    end
  end
end