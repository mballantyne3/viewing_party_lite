require 'rails_helper'

RSpec.describe 'user movies show page' do
  before :each do
    @user1 = User.create!(name: "Mary", email: "random@gmail.com", password: 'something_creative', password_confirmation: 'something_creative')
  end

  it 'has a button to create a viewing party', vcr: 'movie_details' do
    visit "/users/#{@user1.id}/movies/129"
    expect(page).to have_content('Spirited Away')
    expect(page).to have_button('Create Viewing Party')
    expect(page).to have_button('Return to Discover')
  end

  it 'has a button that directs to a form to create new viewing party', vcr: 'top_movies' do
    visit "/users/#{@user1.id}/movies/129"
    click_button 'Create Viewing Party'
    expect(current_path).to eq("/users/#{@user1.id}/movies/129/parties/new")
  end

  it 'shows reviews', vcr: 'movie_details' do
    visit "/users/#{@user1.id}/movies/129"
    expect(page).to have_content("Reviews (1)")
    expect(page).to have_content(
      'One of the great "masters" of the anime art. Somehow, if I would personally associate "Akira" to "self-destruction", then this anime would be the opposite :)'
    )
  end

  it 'shows movie details', vcr: 'movie_details' do
    visit "/users/#{@user1.id}/movies/129"
    expect(page).to have_content("Movie Title: Spirited Away")
    expect(page).to have_content("Vote Average: 8.5")
    expect(page).to have_content("Runtime: 2 hours 5 minutes")
    expect(page).to have_content("Genres: Animation, Family, and Fantasy")
    expect(page).to have_content("Summary: A young girl, Chihiro, becomes trapped in a strange new world of spirits. When her parents undergo a mysterious transformation, she must call upon the courage she never knew she had to free her family.")
  end

  it 'display first 10 cast members', vcr: 'movie_details' do
    visit "/users/#{@user1.id}/movies/129"
    expect(page).to have_content("Rumi Hiiragi")
  end
end
