require 'active_survey/visitor'

module ActiveSurvey
  class SchemaGeneratorVisitor < Visitor
    attr_reader :columns
    attr_reader :model

    def initialize(model)
      @columns = {}
      @model = model
      self.visit_items model.survey
    end

    def visit_question(item)
      # TODO throw error if question name already exists
      @columns[item.name.to_s] = {name: item.name.to_s, type: item.type}
    end

    def columns_to_add
      res = []

      columns.each do |key, value|
        if !model.column_names.include?(key)
          res << value
        end
      end

      res
    end

  end
end