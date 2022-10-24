require 'rails_helper'

RSpec.describe 'user login page' do
  describe 'happy path' do
    it 'has a link to take user to login page' do
      visit '/'

      click_button 'Log In'

      expect(current_path).to eq('/login')
    end

    it 'has fields to enter in unique email and password and are then taken to user dashboard' do
      user1 = User.create!(name: "Legolas", email: "Legolas@email.com", password: "youhavemybow", password_confirmation: "youhavemybow")

      visit '/login'

      fill_in 'Email', with: user1.email
      fill_in 'Password', with: user1.password
      click_on 'Login'

      expect(current_path).to eq(user_path(user1))
    end
  end

  describe 'sad path' do
    it 'shows an error with a flash message if user fails to enter in correct credentials' do
      user2 = User.create!(name: "Gimli", email: "boutdatdwarflife@email.com", password: "youhavemyaxe", password_confirmation: "youhavemyaxe")

      visit '/login'

      fill_in 'Email', with: user2.email
      fill_in 'Password', with: 'dwarvesarenaturalsprinters'
      click_on 'Login'

      expect(page).to have_content("Invalid email/password")
    end
  end
end

