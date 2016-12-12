class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      erb :'users/my_profile'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username] != "" && params[:email] != "" && params[:password] != ""
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      erb :'users/my_profile'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      erb :'users/my_profile'
    else
      erb :'users/login'
    end
  end

  post '/login' do
      @user = User.find_by(username:params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @user = current_user
      erb :'users/my_profile'
    else
      flash[:message] = "Something went wrong, please try again!"
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You have successfully logged out!"
    end
    redirect '/'
  end

  get '/users/:id' do
    if logged_in?
      @user = User.find_by(id: params[:id])
      c = College.find_by(id: params[:id])
      c.name = params[:name]
      c.complete = params[:complete] ? 1 : 0
      c.college_visit = params[:college_visit]
      erb :'users/my_profile'
    else
      redirect to '/login'
    end
  end

 
end