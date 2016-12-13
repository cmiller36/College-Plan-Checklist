class NotesController < ApplicationController

  get '/notes' do
    if logged_in?
      @user = User.find_by(id: params[:id])
      @notes = Note.all
       erb :'notes/index'
    else
      redirect to '/login'
    end
  end

  get '/notes/new' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'notes/new'
    else
      redirect to '/login'
    end
  end

  post '/notes' do
    if params[:title] != ""
      @user = current_user
      @note = Note.create(params)
      @note.user_id = @user.id
      @note.save
      redirect '/notes'
    else
      redirect '/notes/new'
    end
  end

end