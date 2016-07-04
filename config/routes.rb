Rails.application.routes.draw do

# devise_for :users
devise_for :users, :controllers => { registrations: 'registrations'}

resources :charges

resources :dashboard, only: [:show, :index]
# Run rake routes to see what this added.
# DEVISE HELPERS WORTH NOTING:
  # before_action :authenticate_user! (for CONTROLLER)
  # user_signed_in? (Ruby/HTML.ERB)
  # current_user (Ruby/HTML.ERB)
  # user_session (Ruby/HTML.ERB)
# To setup Devise:
  # Gemfile: (+) gem 'devise', '~> 3.4.1' & gem 'responders'
  # Console: bundle
  # Console: rails generate devise:install
  # Console: rails generate devise MODEL (MODEL = User, or Admin, or Member, etc.)
  # config/environments/development.rb: config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  ### THE ABOVE IS A PLACEHOLDER FOR EMAIL VERIFICATION SENDS ###
  # Routes.rb: Add some kind of root_path. Devise will rely on this sometimes.

root to: "root#index"

get "/about" => "static#about"
get "/help" => "static#help"
get "/template" => "static#template"
get "/terms" => "static#terms"
get "/faq" => "static#faq"
# get "/dashboard" => "static#dashboard"

resources :abstract_tools
resources :tools
resources :rentals
resources :line_items

# This is a placeholder. Devise requires a root path as an option.
# Update to proper static homepage when available.
end
