require 'rails_helper'

feature 'Sign up' do
  given(:new_user) { build(:user) }

  scenario 'should add new user' do
    expect {
      visit root_path
      click_link('Sign up', match: :first)
      fill_in 'user_login', with: new_user.login
      fill_in 'user_first_name', with: new_user.first_name
      fill_in 'user_last_name', with: new_user.last_name
      fill_in 'user_birthday', with: new_user.birthday
      fill_in 'user_address', with: new_user.address
      fill_in 'user_city', with: new_user.city
      fill_in 'user_state', with: new_user.state
      fill_in 'user_country', with: new_user.country
      fill_in 'user_zip', with: new_user.zip
      fill_in 'user_email', with: new_user.email
      fill_in 'user_password', with: new_user.password
      fill_in 'user_password_confirmation', with: new_user.password
      click_button 'Sign up'
    }.to change(User, :count).by(1)

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).not_to have_content 'Sign up'
    expect(current_path).to eq root_path
  end

  scenario 'invalid data' do
    expect {
      visit new_user_registration_path
      fill_in 'user_email', with: new_user.email
      click_button 'Sign up'
    }.not_to change(User, :count)

    expect(page).to have_content "Password can't be blank"
    expect(page).to have_css('div.field_with_errors')
  end
end