require 'rails/generators'

class RichTextGenerator < ActiveRecord::Generators::Base

  def setup_richtext
    
  end
  
  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

  def manifest
    image_model = "app/models/image.rb"

    if File.exists?(image_model)
      inject_into_class image_model, Image { "include RichText::Image" }
    else
      template "image.rb", image_model
    end
    
    migration_template "migrations/#{migration_source_name}.rb", "rich_text_#{migration_target_name}"
  end

  private

  def migration_source_name
    if images_table_exists?
      'update_images'
    else
      'create_images'
    end
  end
  
  def migration_target_name
    if images_table_exists?
      "update_images_to_#{schema_version}"
    else
      'create_images'
    end
  end
  
  def images_table_exists?
    ActiveRecord::Base.connection.table_exists?(:images)
  end

end