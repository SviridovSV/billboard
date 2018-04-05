require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'when user signed in' do
    let(:user) { create(:user) }
    before { sign_in user }

    describe 'GET #new' do
      before do
        get :new
      end

      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      it 'redirect to root with valid params' do
        post :create, params: { post: attributes_for(:post, user_id: user.id) }
        expect(response).to redirect_to '/'
      end
      it 'render new if not valid params' do
        post :create, params: { post: { text: '', user_id: user.id } }
        expect(response).to render_template :new
      end
    end

    describe 'GET #show' do
      let(:post) { create(:post, user_id: user.id) }

      it 'renders show template' do
        get :show, params: { id: post }
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      let(:post) { create(:post, user_id: user.id) }

      it 'renders show template' do
        get :edit, params: { id: post }
        expect(response).to render_template :edit
      end
    end

    describe 'PUT #update' do
      context 'current user not author' do
        let(:admin) { create(:admin) }
        let(:post) { create(:post, user_id: admin.id) }

        it 'raise error' do
          expect do
            put :update, params: {
              post: attributes_for(:post, text: 'Ololo'), id: post.id
            }
          end.to raise_error('You are not authorized to access this page.')
        end
      end
      context 'current user is author' do
        let(:post) { create(:post, user_id: user.id) }

        it 'save with valid data' do
          expect do
            put :update, params: {
              post: attributes_for(:post, text: 'Ololo'), id: post.id
            }
          end.to change(Post, :count).by(1)
        end
        it 'redirect to root with valid data' do
          put :update, params: {
            post: attributes_for(:post, text: 'Ololo'), id: post.id
          }
          expect(response).to redirect_to '/'
        end
        it 'render edit when data is not valid' do
          put :update, params: {
            post: attributes_for(:post, text: ''), id: post.id
          }
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'current user not author' do
        let(:admin) { create(:admin) }
        let(:post) { create(:post, user_id: admin.id) }

        it 'raise error' do
          expect do
            delete :destroy, params: { id: post.id }
          end.to raise_error('You are not authorized to access this page.')
        end
      end

      context 'current user is author' do
        let(:post) { create(:post, user_id: user.id) }

        it 'redirect to root' do
           delete :destroy, params: { id: post.id }
           expect(response).to redirect_to '/'
        end
      end
    end
  end
end
