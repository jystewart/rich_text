# require 'rich_text/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
# 
# class RichText < Rails::Engine
#   paths.app                 = "app"
#   paths.app.controllers     = "app/controllers"
#   paths.app.helpers         = "app/helpers"
#   paths.app.models          = "app/models"
#   paths.app.views           = "app/views"
#   paths.lib                 = "lib"
#   paths.lib.tasks           = "lib/tasks"
#   paths.config              = "config"
#   paths.config.routes       = "config/routes.rb"
# end
# 
require 'rich_text/engine'
require '../app/helpers/rich_text_helper'
ActionView::Base.send :include, RichTextHelper