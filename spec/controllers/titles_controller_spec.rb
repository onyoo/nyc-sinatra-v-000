require 'spec_helper'

describe TitlesController do
  before do
    queenb = Figure.create(:name => "Beyonce")
    bqe = Landmark.create(name: 'BQE', year_completed: 1961)
    governator = Title.create(name: 'Governator')
    bqe.figure = queenb
    bqe.save
  end

  after do
    Title.destroy_all
    Figure.destroy_all
  end

  it "allows you to view form to create a new title" do
    visit '/titles/new'
    expect(page.body).to include('<form')
    expect(page.body).to include('title[name]')
  end

  it "allows you to create a new title" do
    visit '/titles/new'
    fill_in :title_name, :with => "Roberto"
    click_button "Create New Title"
    expect(Title.all.count).to eq(2)
  end

  it "allows you to list all titles" do
    visit '/titles'
    
    expect(page.status_code).to eq(200)

    expect(page.body).to include("Governator")
  end

  it "allows you to see a single title" do
    @title = Title.first
    get "/titles/#{@title.id}"
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Governator")
    # expect(last_response.body).to include("1961")
  end

  it "allows you to view form edit a single title" do
    @title = Title.first
    get "/titles/#{@title.id}/edit"

    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('<form')
    expect(last_response.body).to include('title[name]')
    expect(last_response.body).to include(@title.name)
  end

    it "allows you to assign a title to a figure" do
    @figure = Figure.first
    @title = Title.first
    @figure.titles << @title

    expect(@figure.titles).to include(@title)
  end


  it "allows you to edit a single title" do
    @title = Title.first
    visit "/titles/#{@title.id}/edit"
    fill_in :name, with: "BQE!!!!"
    click_button "Edit Title"
    @title = Title.first
    expect(page.current_path).to eq("/titles/#{@title.id}")
    expect(page.body).to include(@title.name)    

  end
end