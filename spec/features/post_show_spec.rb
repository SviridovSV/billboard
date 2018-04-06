require 'rails_helper'

feature 'PostShow' do
  background do
    @user = create(:user)
    @post = create(:post, user_id: @user.id, text: '<h1>Hello</h1> *world*')
    @comment = create(:comment, user_id: @user.id, post_id: @post.id)
    login_as(@user)
    visit post_path(@post.id)
  end

  scenario 'show post info' do
    expect(page).to have_css('div#image')
    expect(page).to have_content('<h1>Hello</h1>')
    expect(page).to have_css('strong', text: 'world')
    expect(page).to have_link('Edit')
    expect(page).to have_link('Delete')
  end

  scenario 'show comments info' do
    expect(page).to have_content(@user.login)
    expect(page).to have_link('Delete')
  end
end
