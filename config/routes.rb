Rails.application.routes.draw do
  resources :editor_images, :controller => 'rich_text/images', :only => [:new, :create]
end