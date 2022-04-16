require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'Logins', type: :feature do
  background { visit new_user_session_path }

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now)

    Post.create(title: 'Software Development', text: 'Remember me ?', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Remember me'
  end

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now)

    Post.create(title: 'Software Development', text: 'Remember me ?', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Remember me'
  end

  scenario "When click on user Should redirected to that user's show page" do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now)
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now)

    Post.create(title: 'Software Development', text: 'Remember me ?', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Remember me'
  end

  scenario "can see the user's bio." do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: "I'm a good person")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: 'Software engineer')

    Post.create(title: 'Software Development', text: 'I love software develoepers', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to have_content @user2.bio
  end

  scenario "can see the user's first 3 posts." do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: "I'm a good person")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: 'Software engineer')

    Post.create(title: 'hello there', text: 'Software developers are great', author_id: @user2.id)
    Post.create(title: 'hello there', text: 'I know you', author_id: @user2.id)
    Post.create(title: 'hello there', text: 'I know you', author_id: @user2.id)
    Post.create(title: 'Thrice', text: 'Iknow you', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page).to_not have_content 'Octopus are scary'
  end

  scenario "can see a button that lets me view all of a user's posts." do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: "I'm a good person")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: 'Software engineer')

    Post.create(title: 'Software Engineering', text: 'Software developers are great', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    expect(page.has_link?('See all posts')).to be true
  end

  scenario "can see a button that lets me view all of a user's posts." do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: "I'm a good person")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: 'Software engineer')

    @post = Post.create(title: 'Software Engineering', text: 'Software developers are great', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page.has_button?('Add Comment')).to be true
  end

  scenario "can see a button that lets me view all of a user's posts." do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: "I'm a good person")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: 'Software engineer')
    @post = Post.create(title: 'Software Engineering', text: 'Software developers are great', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: @user1.email
      fill_in 'Password', with: @user1.password
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    expect(page.has_button?('Pagination')).to be true
  end
  # rubocop:enable Metrics/BlockLength
end
