require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    before do
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }

    context 'when user admin' do
      let(:admin) { create(:admin) }
      before { sign_in admin }

      it 'redirect to user with notice if valid params' do
        put :update, params: {
          user: attributes_for(:user, login: 'JohnDoe'), id: user.id
        }
        expect(response).to redirect_to user_path
      end
      it 'render edit if not valid params' do
        put :update, params: {
          user: attributes_for(:user, login: ''), id: user.id
        }
        expect(response).to render_template :edit
      end
    end

    context 'when user moderator' do
      let(:moderator) { create(:moderator) }
      before { sign_in moderator }

      it 'raise error' do
        expect do
          put :update, params: {
            user: attributes_for(:user, login: 'JohnDoe'), id: user.id
          }
        end.to raise_error('You are not authorized to access this page.')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    context 'when user admin' do
      let(:admin) { create(:admin) }
      before { sign_in admin }

      it 'remove user' do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to users_path
      end
    end

    context 'when user not admin' do
      let(:moderator) { create(:moderator) }
      before { sign_in moderator }

      it 'raise error' do
        expect { delete :destroy, params: { id: user.id } }.to raise_error('You are not authorized to access this page.')
      end
    end
  end
end
