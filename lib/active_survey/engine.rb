module ActiveSurvey
  class Engine < ::Rails::Engine
    isolate_namespace ActiveSurvey

    ActiveSupport.on_load :action_view do
      require 'active_survey/action_view_extensions'
      include ::ActiveSurvey::ActionViewExtensions
    end

  end
end
