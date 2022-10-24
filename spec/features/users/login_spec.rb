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
end
