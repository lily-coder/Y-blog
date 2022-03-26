require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) { get user_posts_path(1) }

    it "should render 'index' template" do
      expect(response).to render_template('index')
    end

    it 'should return the correct placeholder text' do
      expect(response.body).to include('The posts for the users')
    end
  end

  describe 'GET /show' do
    before(:example) { get user_post_path(1, 2) }

    it 'should be a success' do
      expect(response).to have_http_status(:ok)
    end

    it "should render 'show' template" do
      expect(response).to render_template('show')
    end

    it 'should return the correct placeholder text' do
      expect(response.body).to include('Posts for one user')
    end
  end
end
