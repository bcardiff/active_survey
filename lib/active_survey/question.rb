require 'active_survey/survey_item_base'

module ActiveSurvey
  class Question < SurveyItemBase
    attr_reader :name
    attr_accessor :text

    def initialize(name, text, options = {})
      @name = name
      @text = text
      @options = options
    end

    def type
      :string
    end

    def unit
      @options[:unit]
    end
  end
end