class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to '/my_profile'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/my_profile'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/my_profile'
    else
      erb :'users/login'
    end
  end

  post '/login' do
      @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/my_profile'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect '/'
  end

  get '/my_profile' do
    if logged_in?
      erb :'users/my_profile'
    else
      redirect '/login'
    end
  end

end