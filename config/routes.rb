Rails.application.routes.draw do |map|
  map.resources :editor_images, :controller => 'rich_text/images', :only => [:new, :create]
end