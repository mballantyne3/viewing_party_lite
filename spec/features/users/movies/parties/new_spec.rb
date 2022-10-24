require 'rails_helper'

RSpec.describe 'parties/new' do
  before :each do
    @user = User.create(name: 'Sunny', email: 'sunny@email.com', password: 'something_creative', password_confirmation: 'something_creative')
  end
  it 'shows the name of the movie at the top', vcr: 'viewing_party' do
    movie = MovieFacade.find(550)
    visit new_user_movie_party_path(@user.id, movie.id)

    expect(page).to have_content('Fight Club')
  end
  it 'has a duration field that autopopulates with movie runtime in minutes', vcr: 'viewing_party' do
    movie = MovieFacade.find(550)
    visit new_user_movie_party_path(@user.id, movie.id)
    expect(page).to have_field('Party Duration', with: 139)
  end
  it 'has a date and time fields', vcr: 'viewing_party' do
    movie = MovieFacade.find(550)
    visit new_user_movie_party_path(@user.id, movie.id)
    expect(page).to have_select('_start_time_3i', with_selected: Time.now.day.to_s)
    expect(page).to have_select('_start_time_2i', with_selected: Time.now.strftime('%B'))
    expect(page).to have_select('_start_time_1i', with_selected: Time.now.year.to_s)
    expect(page).to have_select('_start_time_4i', with_selected: Time.now.strftime("%I %p"))
  end
  it 'has checkboxes for all users that can be invited', vcr: 'viewing_party' do
    user2 = User.create(name: 'Mary', email: 'mary@email.com', password: 'something_creative', password_confirmation: 'something_creative')
    user3 = User.create(name: 'Bob', email: 'Bob@email.com', password: 'anything_creative', password_confirmation: 'anything_creative')
    user4 = User.create(name: 'Phillip', email: 'Phillip@email.com', password: 'something_new', password_confirmation: 'something_new')
    movie = MovieFacade.find(550)
    visit new_user_movie_party_path(@user.id, movie.id)
    # save_and_open_page
    expect(page).to have_content('mary@email.com')
  end
  it 'form can create a new viewing party', vcr: 'viewing_party' do
    user2 = User.create(name: 'Mary', email: 'mary@email.com', password: 'something_creative', password_confirmation: 'something_creative')
    user3 = User.create(name: 'Bob', email: 'Bob@email.com', password: 'something_new', password_confirmation: 'something_new')
    user4 = User.create(name: 'Phillip', email: 'Phillip@email.com', password: 'something_pw', password_confirmation: 'something_pw')
    
    visit new_user_movie_party_path(@user.id, 550)

    fill_in 'Duration', with: '140'
    select(Time.now.strftime('%Y'), from: '_start_time_1i')
    select(Time.now.strftime('%B'), from: '_start_time_2i')
    select( 3.days.from_now.strftime('%d'), from: '_start_time_3i')
    select('06 PM', from: '_start_time_4i')
    select('15', from: '_start_time_5i')
    check "user_ids[#{user2.id}]"
    check "user_ids[#{user3.id}]"
    click_button 'Create Party'
    expect(current_path).to eq(user_path(@user.id))
  end
end
