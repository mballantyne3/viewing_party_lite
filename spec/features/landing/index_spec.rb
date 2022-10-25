require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  it 'has a landing page with title of application' do
    visit '/'
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has a button to create a new user' do
    visit '/'
    click_on 'Create New User'
    expect(current_path).to eq('/register')
  end

  it 'has a list of existing users by email' do
    @mary = User.create!(name: 'Mary', email: 'newbie_coder24@gmail.com', password: 'password', password_confirmation: 'password')
    @sunny = User.create!(name: 'Sunny', email: 'newemail@gmail.com', password: 'something', password_confirmation: 'something')
    @mackinley = User.create!(name: 'MacKinley', email: 'mrmansemail@gmail.com', password: 'anything', password_confirmation: 'anything')

    visit '/login'
    fill_in 'Email', with: @mary.email
    fill_in 'Password', with: @mary.password
    click_on 'Login'
    visit '/'

    within('#existing_users') do
      expect(page).to have_content("newbie_coder24@gmail.com's Dashboard")
      expect(page).to have_content("newemail@gmail.com's Dashboard")

      click_on "newbie_coder24@gmail.com's Dashboard"
      expect(current_path).to eq("/dashboard")
    end
  end

  it 'has a link to return to landing page' do
    visit '/'

    click_link 'Home'
    expect(current_path).to eq('/')
  end
end
