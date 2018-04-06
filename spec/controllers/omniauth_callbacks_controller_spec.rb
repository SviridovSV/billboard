describe Users::OmniauthCallbacksController, type: :controller do
  context 'correct params' do
    let(:user) { create(:user) }
    before { @controller = Users::OmniauthCallbacksController.new }
    context 'authorization via facebook' do
      before do
        auth_hash('facebook', user.email)
        get :facebook
      end
      it 'authenticate user' do
        expect(warden.authenticated?(:user)).to be_truthy
      end
      it 'set current_user' do
        expect(controller.current_user).to eq user
      end
      it 'redirect to root_path' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
  context 'invalid params' do
    let(:user) { build(:user, email: nil) }
    before do
      auth_hash('facebook', user.email)
      get :facebook
    end
    it { expect(response).to redirect_to(new_user_registration_url) }
  end
end
