require 'active_survey'
require 'rails'
module ActiveSurvey
  class Railtie < Rails::Railtie
    railtie_name :active_survey

    rake_tasks do
      load "tasks/active_survey_tasks.rake"
    end
  end
end