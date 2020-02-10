module Features

  def sign_up(email, username, password, confirmation)
    visit new_user_path

    fill_in 'user_username', with: username
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: confirmation
    click_on 'Sign up!'

  end

end