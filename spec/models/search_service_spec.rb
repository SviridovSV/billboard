require 'rails_helper'

RSpec.describe SearchService do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let!(:post) { create(:post, user_id: user.id) }
  let!(:post1) { create(:post, text: 'ololo', user_id: admin.id) }
  before do
    post.tag_list = 'ruby, rails, it'
    post.save
  end

  it 'returns post by tag' do
    search = SearchService.new('rails', 'by_tag')
    expect(search.filter_by_search_param).to eq([post])
  end

  it 'returns post by author' do
    search = SearchService.new(user.login, 'by_author')
    expect(search.filter_by_search_param).to eq([post])
  end

  it 'returns post by content' do
    search = SearchService.new('lo', 'by_content')
    expect(search.filter_by_search_param).to eq([post1])
  end

  it 'returns post by address' do
    search = SearchService.new('24 tytova', 'by_address')
    expect(search.filter_by_search_param).to eq([post, post1])
  end
end
