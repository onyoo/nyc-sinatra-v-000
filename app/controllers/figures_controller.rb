class FiguresController < ApplicationController

  get '/figures/new' do
    erb :"figures/new"
  end

  post "/figures/new" do
    Figure.find_or_create_by(params["figure"])
    redirect to "/figures"
  end

  get '/figures' do
    @figure = Figure.all
    erb :"figures/index"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  post "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.save
    redirect to :"/figures/#{@figure.id}"
  end

end