class RichTextCreateEditorImages < ActiveRecord::Migration
  def self.up
    create_table :editor_images, :force => true do |t|
      t.string :caption, :attribution, :link
      t.string :upload_file_name, :upload_content_type
      t.integer :upload_file_size, :user_id
      t.datetime :upload_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :editor_images
  end
end