# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New User' do
  it 'Registration page has name, email and register button' do
    visit '/register'

    expect(page).to have_field('Name')
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_field('Password Confirmation')
    expect(page).to have_button('Register')
  end

  describe 'happy path' do
    it 'can register a new user and redirect to their dashboard' do
      visit '/register'

      fill_in 'Name', with: 'Sunny'
      fill_in 'Email', with: 'sunny@email.com'
      fill_in 'Password:', with: 'testpw'
      fill_in 'Password Confirmation:', with: 'testpw'
      click_on 'Register'

      expect(page).to have_content('Welcome, Sunny!')

      user = User.last
      expect(user.name).to eq('Sunny')
      expect(user.email).to eq('sunny@email.com')
      expect(current_path).to eq(user_path(user.id))
    end
  end

  describe 'sad path' do
    it 'displays a flash message if a user fails to fill in correct criteria' do
      visit '/register'

      fill_in 'Email', with: 'MiddleEarthinIt@email.com'
      fill_in 'Password Confirmation', with: 'youhavemysword'
      click_on 'Register'

      expect(page).to have_content("Password can't be blank")
      expect(page).to have_content("Name can't be blank")
    end

    it 'displays an error if the passwords do not match' do
      visit '/register'

      fill_in 'Name', with: 'Aragorn'
      fill_in 'Email', with: 'MiddleEarthinIt@email.com'
      fill_in 'Password:', with: 'youhavemyaxe'
      fill_in 'Password Confirmation:', with: 'youhavemysword'
      click_on 'Register'

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
