module Features

  def sign_in(email, password)
    visit login_path

    fill_in 'session_email', with: email
    fill_in 'session_password', with: password
    click_on 'Log in'

  end

end