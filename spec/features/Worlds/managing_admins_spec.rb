require 'rails_helper'

describe 'Managing admins' do
  let(:owner) { create(:user) }
  let(:admin) { create(:user) }
  let(:user)  { create(:user) }
  let(:world) { create(:world, owner: owner) }
  before :each do
    world.admins << admin
  end

  context 'as a world admin' do

    before :each do
      sign_in(owner.email, 'password')
    end

    it 'should allow revoking admins' do
      visit user_world_path(world.name)
      click_on 'revoke'

      expect(world.is_admin?(admin)).to be false
    end

    it 'should allow adding admins' do
      visit user_world_path(world.name)
      click_on '+'

      fill_in 'admin_username', with: user.username
      click_on 'Add Admin'

      expect(world.is_admin?(user)).to be true
    end
  end

  context 'as a non-admin' do

    before :each do
      sign_in(user.email, 'password')
    end

    it 'should not be possible' do
      expect(page).not_to have_css '.admin-box ul li a', text: 'revoke'
      expect(page).not_to have_css '.admin-box ul li a', text: '+'
    end
  end
end