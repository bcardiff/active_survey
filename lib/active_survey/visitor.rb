module ActiveSurvey
  class Visitor
    def visit_items(items)
      res = items.map { |item| item.accept(self) }
      after_visit_items(items, res)
    end

    def after_visit_items(items, result)
      result
    end

    def visit_question(item)
    end

    def visit_section(item)
      self.visit_items item.items
    end

    def visit_text_item(item)
    end
  end
end