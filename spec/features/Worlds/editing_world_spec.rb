require 'rails_helper'

describe 'A user editing a world' do
  let(:owner) { create(:user) }
  let(:admin) { create(:user) }
  let(:user)  { create(:user) }
  let(:world) { create(:world, owner: owner) }

  before(:each) do
    world.admins << admin
  end

  context 'when not logged in' do
    it 'cannot edit the world' do
      visit user_world_path(world.name)
      expect(page).not_to have_css 'a', text: 'Edit World'
    end
  end

  context 'when logged in as non-Admin' do
    it 'cannot edit the world' do
      sign_in(user.email, 'password')
      visit user_world_path(world.name)
      expect(page).not_to have_css 'a', text: 'Edit World'
    end
  end

  context 'when logged in as Admin' do

    before :each do
      sign_in(admin.email, 'password')
    end

    it 'can edit the world' do
      visit user_world_path(world.name)

      click_on 'Edit World'

      fill_in 'world_name', with: 'New name'
      click_on 'Update'

      expect(page).to have_title 'New name'
    end

    it 'cannot delete the world' do
      visit user_world_path(world.name)

      expect(page).not_to have_css 'a', text: 'Delete'
    end
  end

  context 'when logged in as Owner' do
    before :each do
      sign_in(owner.email, 'password')
    end

    it 'can delete the world' do
      visit user_world_path(world.name)

      click_on 'Delete'

      expect(page).to have_title owner.username
    end
  end
end