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
        item = Question.new(*options)
        add_survey_item item

        class_eval <<-EOV
          # only add to attr_accessible
          # if the class has some mass_assignment_protection

          if defined?(accessible_attributes) and !accessible_attributes.blank?
            attr_accessible :#{item.name}
          end
        EOV
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