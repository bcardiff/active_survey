require 'active_survey/simple_form_survey_visitor'

module ActiveSurvey
  # = Helpers
  module ActionViewExtensions
    def simple_form_render_survey_fields(f, model)
      SimpleFormSurveyVisitor.new(self, f, model).visit_items model.survey
    end
  end
end