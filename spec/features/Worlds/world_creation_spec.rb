require 'rails_helper'

describe 'User making a world' do
  context 'when not logged in' do
    it 'should not be able to' do
      expect(page).not_to have_nav_link 'New World'
    end
  end

  context 'when logged in' do
    let(:user) {create(:user)}

    before(:each) do
      sign_in(user.email, 'password')
    end

    it 'should be able to' do
      create_world('new world')

      expect(page).to have_title 'new world'
    end

    it 'shouldnt be able to duplicate names' do
      create(:world, name: 'repeat', owner: user)
      create_world('repeat')

      expect(page).to have_error_explanation 'name has already been taken'
    end
  end
end