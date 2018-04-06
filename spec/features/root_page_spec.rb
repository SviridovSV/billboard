require 'rails_helper'

feature 'RootPage' do
  background do
    @user = create(:user)
    @post = create(:post, user_id: @user.id)
    visit root_path
  end

  scenario 'show posts info' do
    expect(page).to have_css('img.img.card-img-top')
    expect(page).to have_content(@user.login)
  end
end
