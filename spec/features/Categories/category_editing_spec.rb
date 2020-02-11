require 'rails_helper'

describe 'Editing a category' do
  let(:owner) { create(:user) }
  let(:user)  { create(:user) }
  let(:world) { create(:world, owner: owner) }
  let(:category) { create(:category, sub_wiki: world.sub_wiki) }

  context 'as a non-admin' do
    it 'should not be possible' do
      visit user_world_category_path(world.name, category.name)

      expect(page).not_to have_css 'a', text: 'Edit Category'
    end
  end

  context 'as an admin' do

    before :each do
      sign_in(owner.email, 'password')
    end

    it 'should successfully update the Category' do
      visit user_world_category_path(world.name, category.name)

      click_on 'Edit Category'

      fill_in 'edit_category_name', with: 'new name'
      click_on 'Update!'

      expect(page).to have_title 'Category: new name'
    end

    it 'should allow category deletion' do
      visit user_world_category_path(world.name, category.name)

      click_on 'Delete'

      expect(page).to have_title "#{world.name}'s Wiki"
    end
  end
end