require 'active_survey/survey_item_base'

module ActiveSurvey
  class TextItem < SurveyItemBase
    attr_accessor :text

    def initialize(text)
      @text = text
    end
  end
end