# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Discover page' do
  before :each do
    @user = User.create(name: 'Sunny', email: 'sunny@email.com', password: 'password', password_confirmation: 'password')
    visit '/login'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_on 'Login'
    visit "/discover"
  end

  it 'has a button for top rated movies', vcr: 'top_rated.json' do
    expect(page).to have_button('Top Rated Movies')
    click_button 'Top Rated Movies'
    expect(current_path).to eq("/users/#{@user.id}/movies")
  end

  it 'has a search field and button for searching for a movie by title', :vcr do
    expect(page).to have_content('Movie Title:')
    expect(page).to have_button('Search')
    fill_in 'Movie Title:', with: 'Spirited Away'
    click_button 'Search'
    expect(current_path).to eq("/users/#{@user.id}/movies")
    expect(page).to have_content('Spirited Away (8.5)')
  end

  it 'has a button to return to the discover page', :vcr do
    visit "/users/#{@user.id}/movies"
    click_button 'Return to Discover'
    expect(current_path).to eq("/discover")
  end
end
