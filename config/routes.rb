Rails.application.routes.draw do |map|
  map.resources :images, :controller => 'rich_text/images', :only => [:new, :create]
end