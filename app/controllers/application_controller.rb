require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
   use Rack::Flash

  configure do
    set :views, "app/views"
    set :public_folder, 'public'
    enable :sessions
    set :session_secret, "password_checklist_security"
  end

  get '/' do
    erb :index
  end

  helpers do

    def current_user
     User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end

  end

end
