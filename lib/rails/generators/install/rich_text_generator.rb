require 'rails/generators/active_record'

module RichText
  module Generators
    class InstallGenerator < ActiveRecord::Generators::Base
  
      desc <<DESC
      Description:
          Create or update the Image model/migration for the Rich Text editor
      DESC

      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end

      def install
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
  end
end