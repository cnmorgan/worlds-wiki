require 'rails_helper'

describe 'Editing a page' do
  let(:owner) { create(:user) }
  let(:user)  { create(:user) }
  let(:world) { create(:world, owner: owner) }
  let(:wiki_page) { create(:page, sub_wiki: world.sub_wiki)}
  
  context 'as a non-admin' do
    before :each do
      sign_in(user.email, 'password')
    end
    
    it 'should not be possible' do
      visit world_page_path(world.name, wiki_page.title)

      expect(page).not_to have_css 'a', text: 'Edit page'
    end
  end

  context 'as an admin' do

    before :each do
      sign_in(owner.email, 'password')
    end

    it 'should update the page successfully' do
      visit world_page_path(world.name, wiki_page.title)

      click_on 'Edit page'

      fill_in 'page_edit_title', with: 'New Title'
      fill_in 'page_edit_edit_summary', with: 'Change title'
      click_on 'Update!'

      expect(page).to have_title 'New Title'
    end

    it 'should require an edit summary' do
      visit world_page_path(world.name, wiki_page.title)

      click_on 'Edit page'

      fill_in 'page_edit_title', with: 'New Title'
      click_on 'Update!'

      expect(page).to have_error_explanation 'edit summary cannot be blank'
    end
  end
end

