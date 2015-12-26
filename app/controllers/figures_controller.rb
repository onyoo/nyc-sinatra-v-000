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

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    @titles = @figure.titles == [] ? "None" : @figure.titles
    @landmarks = @figure.landmarks == [] ? "None" : @figure.landmarks
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  post "/figures/:id" do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]

    if params[:delete_title]
      title_mark = Title.find_by(name: params[:delete_title][:title].strip)
      Title.delete(title_mark.id)
      @figure.titles.delete(title_mark)
    end

    @figure.titles << Title.find_or_create_by(name: params[:figure][:title])


    if params[:delete_landmark]
      landmark_mark = Landmark.find_by(name: params[:delete_landmark][:landmark].strip)
      Landmark.delete(landmark_mark.id)
      @figure.landmarks.delete(landmark_mark)
    end
    @figure.landmarks << Landmark.find_or_create_by(name: params[:figure][:landmark])
    
    @figure.save
    redirect to :"/figures/#{@figure.id}"
  end

end