require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { User.new(name: 'Lilian', bio: 'Engineer from Nakuru, Kenya.', password: 'mypassword') }

    before { subject.save }

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'bio should be present' do
      subject.bio = nil
      expect(subject).to_not be_valid
    end

    it 'User should have post greater than or equal to 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'Should test recent post method' do
    before { 3.times { |post| Post.create(author: subject, title: "Post number #{post}") } }

    it 'user should have three recent posts' do
      expect(subject.recent_post).to eq(subject.posts.last(3))
    end
  end
end
