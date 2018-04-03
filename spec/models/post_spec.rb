require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validation' do
    it { should validate_presence_of(:text) }
  end

  describe 'Associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should belong_to(:user) }
  end

  describe 'Scopes' do
    let(:signed_user) { create(:user) }
    let(:post) { create(:post, user_id: signed_user.id, text: FFaker::LoremRU.paragraph) }

    describe '.filter_by_author' do

      it 'include post with author' do
        expect(Post.filter_by_author(signed_user.login)).to include(post)
      end

      it 'not include post with another author' do
        expect(Post.filter_by_author('lloo')).not_to include(post)
      end
    end

    describe '.filter_by_content' do

      it 'include post with content' do
        search_phrase = post.text[post.text.length / 2, 3]
        expect(Post.filter_by_content(search_phrase)).to include(post)
      end

      it 'not include post with another content' do
        search_phrase = [*('a'..'z')].sample(8).join
        expect(Post.filter_by_content(search_phrase)).not_to include(post)
      end
    end

    describe '.filter_by_address' do

      it 'include post with address' do
        expect(Post.filter_by_address(signed_user.address)).to include(post)
      end

      it 'not include post with another address' do
        search_address = [*('a'..'z')].sample(5).join
        expect(Post.filter_by_address(search_address)).not_to include(post)
      end
    end
  end

  describe 'Tags' do
    let(:post) { create(:post) }

    it 'have in tag_list' do
      expect(post).to respond_to(:tag_list)
    end

    it 'have separate from tag_list' do
      post.tag_list = 'ruby, rails, it'
      post.save
      expect(post.tags.group_by{ |tag| tag.name }).to include('rails')
    end

    it 'allow to find by tag name' do
      post.tag_list = 'ruby, rails, it'
      post.save
      expect(Post.tagged_with('rails')).to include(post)
    end
  end

  describe 'Image' do
    let(:post) { create(:post) }

    it 'can be downloaded' do
      path_to_png_file = Rails.root + 'app/assets/images/NoImageAvailable.png'
      File.open(path_to_png_file) { |f| post.image.store!(f) }
      expect(post.image.filename).to be == 'NoImageAvailable.png'
    end
  end
end
