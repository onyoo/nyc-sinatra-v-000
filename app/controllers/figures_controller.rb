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
    @titles = @figure.titles unless @figure.titles == []
    @landmarks = @figure.landmarks unless @figure.landmarks == []

    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  post "/figures/:id" do

    @figure = Figure.find(params[:id])

    if params[:figure][:name] != ""
      @figure.name = params[:figure][:name]
    end

    if params[:delete_title]
      title_mark = Title.find_by(name: params[:delete_title][:title].strip)
      Title.delete(title_mark.id)
      @figure.titles.delete(title_mark)
    end

    if params[:figure][:title].strip != ""
      @figure.titles << Title.find_or_create_by(name: params[:figure][:title])
    end

    if params[:delete_landmark]
      landmark_mark = Landmark.find_by(name: params[:delete_landmark][:landmark].strip)
      Landmark.delete(landmark_mark.id)
      @figure.landmarks.delete(landmark_mark)
    end

    if params[:delete_landmark]
      @figure.landmarks << Landmark.find_or_create_by(name: params[:figure][:landmark])
    end

    if params[:set_landmark].keys.count > 0
      params[:set_landmark].keys.each do |l|
        @figure.landmarks << Landmark.find_or_create_by(name: l)
      end
    end

    @figure.save
    redirect to :"/figures/#{@figure.id}"
  end

end