require 'rails/generators/active_record'

class RichTextGenerator < ActiveRecord::Generators::Base

#   desc <<DESC
# Description:
#     Create or update the Image model/migration for the Rich Text editor
# DESC

  argument :name, :type => :string, :default => "migration_name"

  def self.source_root
    @source_root ||= File.join(File.dirname(__FILE__), 'templates')
  end

  # def setup_model
  #   image_model = "app/models/image.rb"
  # 
  #   if File.exists?(image_model)
  #     inject_into_class image_model, Image { "include RichText::Image" }
  #   else
  #     template "image.rb", image_model
  #   end
  # end
  
  def setup_migration
    migration_template "migrations/#{migration_name}.rb", "rich_text_#{migration_name}"
  end

  private

  def migration_name
    if images_table_exists?
      'update_editor_images'
    else
      'create_editor_images'
    end
  end
  def images_table_exists?
    ActiveRecord::Base.connection.table_exists?(:editor_images)
  end
end