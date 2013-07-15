namespace :survey do
  desc "Generates activerecord migrations for survey models"
  task :migrate => [:'db:migrate', :environment] do 
    get_surveys().each do |model|
      add_missing_columns(model)
    end

    Rake::Task["db:migrate"].execute
  end

  def load_models
    patterns = ActiveSupport::Dependencies.autoload_paths.map { |p| File.join(p, '**', '*.rb') }
    Dir.glob(patterns).each { |f| require_or_load f }
  end

  def get_surveys
    load_models

    ActiveRecord::Base.descendants.select &:is_survey?
  end

  def add_missing_columns(model)
    columns_to_add = []
    model.survey.each do |item|
      if !model.column_names.include?(item.name.to_s)
        columns_to_add << {name: item.name, type: item.type}
      end
    end

    if !columns_to_add.empty?
      puts "generating migrations for #{model.model_name}"

      column_names_to_add = (columns_to_add.map { |e| e[:name].capitalize }).join('')
      command = "rails g migration Add#{column_names_to_add}To#{model.table_name.capitalize}"
      columns_to_add.each do |col|
        command << " #{col[:name]}:#{col[:type]}"
      end
      `#{command}`
    end
  end
end