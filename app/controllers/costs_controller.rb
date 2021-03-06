class CostsController < ApplicationController
  # Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying

  get '/costs' do
    authenticate_user
    @user = current_user
    @client = current_client
    @project = current_project
    erb :'costs/index'
  end

  get '/costs/new' do
    authenticate_user
    @user = current_user
    @client = current_client
    @project = current_project
    erb :'costs/new'
  end

  post '/costs' do
    authenticate_user
    @cost = current_project.costs.build(params[:cost])
    if @cost.save
      redirect '/costs'
    else
      @client = current_client
      @project = current_project
      erb :'costs/new'
    end
  end

  get '/costs/:id/edit' do
    authenticate_user
    @user = current_user
    @client = current_client
    @project = current_project
    @cost = @project.costs.find_by_id(params[:id])
    session[:cost_id] = @cost.id
    erb :'costs/edit'
  end

  patch '/costs' do
    authenticate_user
    @cost = Cost.find_by(id: session[:cost_id]) if session[:cost_id]
    @cost.update(params[:cost])
    if !@cost.valid?
      @client = current_client
      @project = current_project
      erb :'costs/edit'
    else
      redirect '/costs'
    end
  end

  delete '/costs/:id/delete' do
    authenticate_user
    cost = current_project.costs.find(params[:id])
    cost.delete
    redirect '/costs'
  end

end
