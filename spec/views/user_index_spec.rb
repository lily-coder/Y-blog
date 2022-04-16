require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }
  scenario 'Page should have username of other users' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Email'
  end

  scenario 'Page should have profile photo for each user' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    expect(page).to have_content 'Email'
  end

  scenario 'Should see number of post for each user' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now)

    Post.create(title: 'Hey', text: 'Software Developers are great', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    expect(page).to have_content "Email"
    expect(page).to have_content "Email"
  end

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, id: 1)
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, id: 2)

    Post.create(title: 'Email', text: 'Emails and passwords are secrets', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    expect(page).to have_content 'Email'
  end
  # rubocop:enable Metrics/BlockLength
end
