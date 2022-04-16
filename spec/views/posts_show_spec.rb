require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.feature 'User Index', type: :feature do
  background { visit new_user_session_path }

  scenario "I can see the post's title." do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now,
                         bio: "Software Engineer from Nakuru, Kenya.")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer from Nakuru, Kenya.')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'adri@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @post.title
  end

  scenario 'I can see who wrote the post.' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: "Software")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @user2.name
  end

  scenario 'I can see how many comments it has.' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: "Software")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    @coment = Comment.create(text: ' comment one', author_id: @user2.id,
                             post_id: @post.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content "Comments"
  end

  scenario 'I can see how many likes it has.' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: "Software")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content 'Likes'
  end

  scenario 'I can see the post body.' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: "Software")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @post.text
  end

  scenario 'I can see the username of each commentor.' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: "Software")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    @coment1 = Comment.create(text: ' comment one', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' coment two', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' comment three', author_id: @user1.id, post_id: @post.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @user1.name
    expect(page).to have_content @user2.name
  end

  scenario 'I can see the comment each commentor left.' do
    @user1 = User.create(name: 'Lilian', email: 'lilyondie@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: "Software")
    @user2 = User.create(name: 'Adrian', email: 'adri@gmail.com', password: 'mypassword', confirmed_at: Time.now, bio: 'Farmer')

    @post = Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    @coment1 = Comment.create(text: ' comment one', author_id: @user2.id,
                              post_id: @post.id)
    @coment2 = Comment.create(text: ' coment two', author_id: @user2.id, post_id: @post.id)
    @coment3 = Comment.create(text: ' comment three', author_id: @user1.id, post_id: @post.id)
    Like.create(author_id: @user2.id, post_id: @post.id)

    Post.create(title: 'Hello guys', text: 'Here is another post', author_id: @user2.id)
    within 'form' do
      fill_in 'Email', with: 'lilyondie@gmail.com'
      fill_in 'Password', with: 'mypassword'
    end
    click_button 'Log in'
    find("a[href='#{user_path(@user2.id)}']").click
    find("a[href='#{user_posts_path(@user2.id)}']").click
    find("a[href='#{user_post_path(@user2.id, @post.id)}']").click
    expect(page).to have_content @coment1.text
    expect(page).to have_content @coment2.text
  end
  # rubocop:enable Metrics/BlockLength
end
