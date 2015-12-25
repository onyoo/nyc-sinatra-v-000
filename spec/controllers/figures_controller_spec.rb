require 'spec_helper'

describe FiguresController do
  before do
    queenb = Figure.create(:name => "Beyonce")
    bqe = Landmark.create(name: 'BQE', year_completed: 1961)
    bqe.figure = queenb
    bqe.save
  end

  after do
    Figure.destroy_all
  end

  it "allows you to view form to create a new figure" do
    visit '/figures/new'
    expect(page.body).to include('<form')
    expect(page.body).to include('figure[name]')
  end

  it "allows you to create a new figure" do
    visit '/figures/new'
    fill_in :figure_name, :with => "Roberto"
    click_button "Create New Figure"
    expect(Figure.all.count).to eq(2)
  end

  it "allows you to list all figures" do
    visit '/figures'
    
    expect(page.status_code).to eq(200)

    expect(page.body).to include("Beyonce")
  end

  it "allows you to see a single figure" do
    @figure = Figure.first
    get "/figures/#{@figure.id}"
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Beyonce")
    # expect(last_response.body).to include("1961")
  end

  it "allows you to view form edit a single figure" do
    @figure = Figure.first
    get "/figures/#{@figure.id}/edit"

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('<form')
    expect(last_response.body).to include('figure[name]')
    expect(last_response.body).to include(@figure.name)    


  end


  it "allows you to edit a single figure" do
    @figure = Figure.first
    visit "/figures/#{@figure.id}/edit"
    fill_in :name, with: "BQE!!!!"
    click_button "Edit Figure"
    @figure = Figure.first
    expect(page.current_path).to eq("/figures/#{@figure.id}")
    expect(page.body).to include(@figure.name)    

  end
end