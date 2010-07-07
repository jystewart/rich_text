class RichText < Rails::Engine
  paths.app                 = "app"
  paths.app.controllers     = "app/controllers"
  paths.app.helpers         = "app/helpers"
  paths.app.models          = "app/models"
  paths.app.views           = "app/views"
  paths.lib                 = "lib"
  paths.lib.tasks           = "lib/tasks"
  paths.config              = "config"
  paths.config.routes       = "config/routes.rb"
end

