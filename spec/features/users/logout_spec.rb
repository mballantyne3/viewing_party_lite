require 'rails_helper'

RSpec.describe 'user logout feature' do
  before :each do
    user1 = User.create!(name: "Legolas", email: "Legolas@email.com", password: "youhavemybow", password_confirmation: "youhavemybow")
    visit '/login'
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Login'
  end

  describe 'landing page of signed in user' do
    it 'has a button to logout a user that is signed in and can no longer see login or create an account button' do
      visit '/'
      expect(page).to_not have_button('Log In')
      expect(page).to have_button('Logout')
    end

    xit 'changes back to login button after logout has been selected' do
      visit '/'
      click_button 'Logout'
      expect(current_path).to eq('/logout')
      expect(page).to have_button('Log In')
    end
  end
end
