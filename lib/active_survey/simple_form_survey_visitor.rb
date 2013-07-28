require 'active_survey/visitor'

module ActiveSurvey
  class SimpleFormSurveyVisitor < Visitor
    def initialize(view_context, form, model)
      @view_context = view_context
      @form = form
      @model = model
    end

    def after_visit_items(items, result)
      result.join("\n").html_safe
    end

    def visit_text_item(item)
      render_partial 'text_item', item
    end

    def visit_question(item)
      render_partial 'question', item
    end

    def visit_section(item)
      render_partial 'section', item
    end

    protected

    def render_partial(partial_name, item)
      locals = { f: @form, model: @model, item: item, visitor: self }
      @view_context.render partial: "active_survey/simple_form_survey_visitor/#{partial_name}", locals: locals
    end
  end
end