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

  get '/notes/:id' do
    if logged_in?
      @note = Note.find(params[:id])
      erb :'notes/show'
    else
      redirect to '/login'
    end
  end

  get '/notes/:id/edit' do
    @note = Note.find(params[:id])
    erb :'notes/edit'
  end

  patch '/notes/:id' do
    @note = Note.find(params[:id])
    @note.update(title: params[:note][:title], content: params[:note][:content])
    if @note.save
      redirect to '/notes'
    else
      redirect to '/notes/#{params[:id]}/edit'
    end
  end

  delete '/notes/:id/delete' do
        @note = Note.find(params[:id])
        if @note.user_id == current_user.id
          @note.delete
          flash[:message] = "Your note has been successfully deleted"
          redirect to '/notes'
        else
          redirect to '/login'
        end
    end

end