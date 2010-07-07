<%
existing_columns = ActiveRecord::Base.connection.columns(:editor_images).collect { |each| each.name }

columns = [
  [:caption, 't.string :caption'],
  [:attribution, 't.string :attribution'],
  [:link, 't.string :link'],
  [:upload_file_name, 't.string :upload_file_name'],
  [:upload_content_type, 't.string :upload_content_type'],
  [:upload_file_size, 't.integer :upload_file_size'],
  [:user_id, 't.integer :user_id'],
  [:upload_updated_at, 't.datetime :upload_updated_at']
].delete_if {|c| existing_columns.include?(c.first.to_s)}
-%>

class RichTextUpdateEditorImages < ActiveRecord::Migration
  def self.up
    change_table(:editor_images) do |t|
<% columns.each do |c| -%>
      <%= c.last %>
<% end -%>
    end
  end

  def self.down
    change_table(:editor_images) do |t|
<% unless columns.empty? -%>
      t.remove <%= columns.collect { |each| ":#{each.first}" }.join(',') %>
<% end -%>
    end
  end
end