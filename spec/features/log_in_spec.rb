require 'rails_helper'

feature 'Log in' do
  given(:user) { create(:user) }

  scenario 'log in as persisted user' do
    visit root_path
    click_link('Log in', match: :first)
    fill_in 'user_email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(page).not_to have_content 'Log in'
    expect(current_path).to eq root_path
  end

  scenario 'invalid data' do
    visit new_user_session_path
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
    expect(page).to have_content 'Log in'
    expect(page).to have_content 'Sign up'
    expect(current_path).to eq new_user_session_path
  end
end