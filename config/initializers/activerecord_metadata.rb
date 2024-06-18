# frozen_string_literal: true

require 'active_record/metadata'

ActiveRecord::Metadata.configure do |config|
  # Default config.tags = []
  config.tags = %w[personal_data senstive_data]

  # Default config.models = []
  config.models = proc {
    Rails.application.eager_load!

    ApplicationRecord.descendants.reject do |model|
      model.table_name.blank? || model.superclass != ApplicationRecord
    end
  }

  # # Default config.tag_default_rules = nil
  config.tag_default_rules = lambda { |column, tag|
    string_column = %w[text string jsonb json].include?(column.type.to_s)

    case tag
    when 'personal_data', 'senstive_data'
      string_column ? config.tag_undefined_value : false
    end
  }

  # # Default config.tags_allowed_values = {}
  # config.tags_allowed_values = {
  #   'personal_data' => %w[Yes No TBD]
  # }

  # Default config.metadata_file_path_prefix = 'db'
  # config.metadata_file_path_prefix

  # Default config.metadata_file_name = 'schema_metadata'
  # config.metadata_file_name

  # Default config.metadata_file_format = 'yaml'
  # config.metadata_file_format

  # Default config.tag_undefined_value = ":FIXME"
  # config.tag_undefined_value

  # Default config.default_tag_allowed_values = [true, false]
  # config.default_tag_allowed_values
end
