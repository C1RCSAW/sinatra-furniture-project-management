class ProjectsController < ApplicationController
  # Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying

  get '/projects' do
    authenticate_user
    @user = User.find(current_user.id)
    @client = current_user.clients.find_by(name: params[:client])
    erb :'projects/index'
  end

  get '/projects/new' do
    authenticate_user
    @user = User.find(current_user.id)
    @client = @user.clients.find_by(name: params[:client])
    erb :'projects/new'
  end

  post '/projects' do
    authenticate_user
  end

  get '/projects/:id' do
    authenticate_user
    @user = User.find(current_user.id)
    @client = Client.find_by_id(params[:id])
    @project = Project.find_by_id(params[:id])
    erb :'projects/show'
  end

  get '/projects/:id/edit' do
    erb :'clients/edit'
  end

  patch '/projects/:id' do
    authenticate_user
  end

  delete '/projects/:id/delete' do
    authenticate_user
    @project = Project.find(params[:id])
    @project.delete
    redirect '/projects'
  end

end
