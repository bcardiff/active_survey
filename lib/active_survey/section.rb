require 'active_survey/survey_item_base'

module ActiveSurvey
  class Section < SurveyItemBase
    attr_accessor :text
    attr_accessor :items

    def initialize(text)
      @text = text
      @items = []
    end
  end
end