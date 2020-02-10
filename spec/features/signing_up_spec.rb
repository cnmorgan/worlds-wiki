require 'rails_helper'

describe 'User signing up' do

  context 'using valid email' do

    context 'and password' do
      it 'should redirect with confirmation alert' do
        sign_up("example@example.com", 'user', "password", "password")

        expect(page).to have_alert 'Please check your email to activate your account'
      end

      it 'should be able to be activated' do
        sign_up("activate@example.com", 'activateuser', "password", "password")

        user = User.find_by(email: 'activate@example.com')

        user.send('reset_activation_digest')

        visit account_activation_url(id: user.activation_token, email: user.email)

        expect(page).to have_title user.username
      end
    end

    context 'and mismatched password confirmation' do
      it 'should give a validation error' do
        sign_up("secondExample@example.com", 'user', 'password', 'passedword')

        expect(page).to have_error_explanation "password_confirmation doesn't match Password"
      end
    end
  end

  context 'using repeated email' do
    it 'should give a validation error' do
      create(:user, email: 'repeat@email.com')
      sign_up('repeat@email.com', 'user', 'password', 'password')

      expect(page).to have_error_explanation 'email has already been taken'
    end
  end

  context 'using repeated username' do
    it 'should give a validation error' do
      create(:user, username: 'repeatme')
      sign_up('test@email.com', 'repeatme', 'password', 'password')

      expect(page).to have_error_explanation 'username has already been taken'
    end
  end

end