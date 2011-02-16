require 'digest/sha1'

module RichText
  module Image
    extend ActiveSupport::Concern
    
    included do
      has_attached_file :upload, :styles => { 
          :regular => ["400x400>", :jpg],
          :medium => ["200x200", :jpg],
          :small => ["100x100", :jpg],
          :tiny => ["50x50", :jpg]
      }
      validates_attachment_presence :upload
      belongs_to :user
    end
    
    def link
      read_attribute(:link).blank? ? upload.url(:original) : read_attribute(:link)
    end
  end
end
