require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

require File.expand_path('../boot', __FILE__)


 

module SampleApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    
	 
config.time_zone = "Pacific/Auckland"
	config.active_record.default_timezone = :local
	
	config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
  html_tag
}
    
  end
end
