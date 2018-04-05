require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    let(:comment_user) { create(:user, login: 'lll', email: 'lll@ll.ll') }
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

    context 'when not valid data' do
      it 'not saves comment' do
        expect do
          post :create, params: {
            post_id: post1.id, comment: attributes_for(:comment, body: nil, post_id: post1.id, user_id: comment_user.id)
          }
        end.not_to change(Comment, :count)
      end

      it 'redirect to post page with notice' do
        post :create, params: {
          post_id: post1.id, comment: attributes_for(:comment, body: nil, post_id: post1.id, user_id: comment_user.id)
        }
        expect(response).to redirect_to post1
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:comment_user) { create(:user, login: 'lll', email: 'lll@ll.ll') }
    let(:post1) { create(:post) }
    let(:comment) { create(:comment, post_id: post1.id, user_id: comment_user.id)}
    before { sign_in comment_user }

    it 'redirect to post page' do
      delete :destroy, params: {
        post_id: post1.id, id: comment.id
      }
      expect(response).to redirect_to post1
    end
  end
end
