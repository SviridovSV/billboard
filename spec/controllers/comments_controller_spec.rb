require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:comment_user) { create(:user, login: 'lll', email: 'lll@ll.ll')}
    let(:post1) { create(:post) }
    before { sign_in comment_user }

    context 'when valid data' do
      it 'saves comment' do
        expect do
          post :create, params: {
            post_id: post1.id, comment: attributes_for(:comment, post_id: post1.id, user_id: comment_user.id)
          }
        end.to change(Comment, :count).by(1)
      end
    end
  end
end
