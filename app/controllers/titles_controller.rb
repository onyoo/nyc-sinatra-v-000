class TitlesController < ApplicationController

  get '/titles/new' do
    erb :"titles/new"
  end

  post "/titles/new" do
    Title.find_or_create_by(params["title"])
    redirect to "/titles"
  end

  get '/titles' do
    @title = Title.all
    erb :"titles/index"
  end

  get '/titles/:id' do
    @title = Title.find(params[:id])
    erb :"titles/show"
  end

  get '/titles/:id/edit' do
    @title = Title.find(params[:id])
    erb :"titles/edit"
  end

  post "/titles/:id" do
    @title = Title.find(params[:id])
    @title.name = params[:title][:name]
    @title.save
    redirect to :"/titles/#{@title.id}"
  end

end