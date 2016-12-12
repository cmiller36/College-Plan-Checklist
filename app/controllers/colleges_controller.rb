class CollegesController < ApplicationController

  get '/colleges' do
    if logged_in? 
      erb :'colleges/index'
    else
      redirect to '/login'
    end 
  end

   get '/colleges/new' do
    if logged_in?
      @user = User.find(session[:user_id])
      erb :'colleges/new'
    else
      redirect to '/login'
    end
  end

  post '/colleges' do
    if params[:name] != ""
      @user = current_user
      @college = College.create(name: params[:college][:name], complete: params[:college][:complete], college_visit: params[:college][:college_visit], user_id:@user.id)
      @college.user_id =  @user.id
      @college.save
      redirect '/colleges'
    else
      redirect '/colleges/new'
    end
  end
    

  get '/colleges/:id' do
    if logged_in?
      @college = College.find(params[:id])
      erb :'colleges/show'
    else
      redirect to '/login'
    end
  end

  get '/colleges/:id/edit' do
    if logged_in?
        @college = College.find(params[:id])
        erb :'colleges/edit'
    else
        redirect to '/login'
    end
  end

    patch '/colleges/:id' do
        @college = College.find(params[:id])
        @college.update(name: params[:college][:name], complete: params[:college][:complete], college_visit: params[:college][:college_visit])
        if @college.save
            redirect to '/colleges'
        else
            redirect to '/colleges/#{params[:id]}/edit'
        end
    end

    delete '/colleges/:id/delete' do
        @college = College.find(params[:id])
        if @college.user_id == current_user.id
          @college.delete
          flash[:message] = "Your college has been successfully deleted"
          redirect to '/colleges'
        else
          redirect to '/login'
        end
    end


end