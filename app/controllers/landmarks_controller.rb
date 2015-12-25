class LandmarksController < ApplicationController
  get '/landmarks/new' do
    erb :"landmarks/new"
  end

  post "/landmarks/new" do
    Landmark.find_or_create_by(params["landmark"])
    redirect to "/landmarks"
  end

  get '/landmarks' do
    @landmark = Landmark.all
    erb :"landmarks/index"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/edit"
  end

  post "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    @landmark.name = params[:landmark][:name]
    @landmark.year_completed = params[:landmark][:year_completed]
    @landmark.save
    redirect to :"/landmarks/#{@landmark.id}"
  end
end