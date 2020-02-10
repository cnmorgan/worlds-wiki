require 'rails_helper'

describe 'User signing in' do

  context 'that does not exist' do
    it 'cannot sign in' do
      sign_in("notexist@example.com", "example")

      expect(page).to have_css '.alert', text: 'Invalid Email'
    end
  end

  context 'that exists' do
    context 'and is activated' do
      let(:user) {create(:user, username: 'example')}
      
      it 'can sign in' do      
        sign_in(user.email, 'password')

        expect(page).to have_css '#page-title', text: 'example'
      end

    end

    context 'and is not activated' do
      let(:user) {create(:user, :unactivated, username: 'example')}
      
      it 'cannot sign in' do      
        sign_in(user.email, 'password')

        expect(page).to have_css '.alert', text: 'Account not activated. Check your email for the activation link.'
      end
    end
  end
end