require 'active_survey/text_item'
require 'active_survey/question'

module ActiveSurvey
  module ActsAsSurvey
    extend ActiveSupport::Concern
 
    included do
      def survey
        self.class.survey
      end
    end
 
    module ClassMethods
      attr_accessor :survey
      
      def is_survey?
        @is_survey
      end

      def acts_as_survey
        @is_survey = true
        yield
      end

      def text(*options)
        add_survey_item TextItem.new(*options)
      end

      def q(*options)
        add_survey_item Question.new(*options)
      end

      private

      def add_survey_item(item)
        @survey ||= []
        @survey << item
      end

    end
  end
end

ActiveRecord::Base.send :include, ActiveSurvey::ActsAsSurvey