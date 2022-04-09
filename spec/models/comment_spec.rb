require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Validations' do
    subject { Comment.new(text: 'This is my first post', author_id: 3, post_id: 2) }

    before { subject.save }

    it 'title should not be valid' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'author id should be a number' do
      subject.author_id = 'a'
      expect(subject).to_not be_valid
    end

    it 'post id should be a number' do
      subject.post_id = 'look'
      expect(subject).to_not be_valid
    end
  end
end