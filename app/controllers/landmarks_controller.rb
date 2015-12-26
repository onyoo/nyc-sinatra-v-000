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
    @figures = @landmark.figure unless @landmark.figure == []
    erb :"landmarks/show"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :"landmarks/edit"
  end

  post "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])

    if params[:landmark][:name] != ""
      @landmark.name = params[:landmark][:name]
    end

    if params[:landmark][:year_completed] != ""
      @landmark.year_completed = params[:landmark][:year_completed]
    end

    @landmark.save
    redirect to :"/landmarks/#{@landmark.id}"
  end
end