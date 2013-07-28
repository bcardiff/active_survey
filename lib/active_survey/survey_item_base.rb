class SurveyItemBase
  def accept(visitor)
    visitor.send ('visit_' + self.class.name.demodulize.underscore).to_sym, self
  end
end