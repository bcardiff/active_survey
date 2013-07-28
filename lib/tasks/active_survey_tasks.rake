migrate_db = ENV["db"] || "yes"

namespace :survey do

  desc "Generates activerecord migrations for survey models. db=no to not execute migrations on database."
  task :migrate => [:'db:migrate', :environment] do 
    get_surveys().each do |model|
      add_missing_columns(model)
    end

    Rake::Task["db:migrate"].execute if migrate_db == 'yes'
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
    schema_generator = ActiveSurvey::SchemaGeneratorVisitor.new model
    columns_to_add = schema_generator.columns_to_add

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