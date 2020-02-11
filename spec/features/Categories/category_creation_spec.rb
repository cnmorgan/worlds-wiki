require 'rails_helper'

describe 'Making a category' do
  let(:owner) { create(:user) }
  let(:user)  { create(:user) }
  let(:world) { create(:world, owner: owner) }

  context 'as a non admin' do

    before :each do
      sign_in(user.email, 'password')
    end

    it 'should not be possible' do
      visit user_world_path(world.name)

      expect(page).not_to have_css 'a', text: 'New Category'
    end
  end

  context 'as an admin' do

    before :each do
      sign_in(owner.email, 'password')
    end

    it 'should create successfully' do
      visit user_world_path(world.name)

      click_on 'New Category'

      fill_in 'new_category_name', with: 'New Category'
      click_on 'Create!'

      expect(page).to have_title 'New Category'
    end

    it 'should give an error when the name is blank' do
      visit user_world_path(world.name)
      click_on 'New Category'

      fill_in 'new_category_name', with: ''
      click_on 'Create!'

      expect(page).to have_error_explanation "name can't be blank"
    end

    it 'should give an error when the name is a duplicate' do
      create(:category, name: 'repeat', sub_wiki: world.sub_wiki)
      visit user_world_path(world.name)
      click_on 'New Category'

      fill_in 'new_category_name', with: 'repeat'
      click_on 'Create!'

      expect(page).to have_error_explanation "name already exists"
    end
  end
end