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
    @figure = @title.figures unless @title.figures == []
    erb :"titles/show"
  end

  get '/titles/:id/edit' do
    @title = Title.find(params[:id])
    erb :"titles/edit"
  end

  post "/titles/:id" do
    @title = Title.find(params[:id])

    if params[:title][:name] != ""
      @title.name = params[:title][:name]
    end

    if params[:delete_figures]
      title_mark = Figure.find_by(name: params[:delete_figures][:figure].strip)
      Figure.delete(title_mark.id)
      @title.figures.delete(title_mark)
    end

    if params[:title][:title].strip != ""
      @title.figures << Figure.find_or_create_by(name: params[:title][:title].strip)
    end

    @title.save
    redirect to :"/titles/#{@title.id}"
  end

end