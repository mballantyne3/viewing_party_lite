require 'rails_helper'

RSpec.describe 'New User' do
  it 'Registration page has name, email and register button' do
    visit '/register'

    expect(page).to have_field('Name')
    expect(page).to have_field('Email')
    expect(page).to have_button('Register')
  end
  it 'can register a new user and redirect to their dashboard' do
    visit '/register'

    fill_in 'Name', with: 'Sunny'
    fill_in 'Email', with: 'sunny@email.com'
    click_on 'Register'

    user = User.last
    expect(user.name).to eq('Sunny')
    expect(user.email).to eq('sunny@email.com')
    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content('Welcome, Sunny!')
  end
end