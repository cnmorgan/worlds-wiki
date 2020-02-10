require 'rails_helper'

describe 'User creating a page' do
  let(:owner) { create(:user) }
  let(:user)  { create(:user) }
  let(:world) { create(:world, owner: owner) }

  context 'as a non-admin' do

    before :each do
      sign_in(user.email, 'password')
    end

    it 'should not be possible' do
      visit user_world_path(world.name)

      expect(page).not_to have_nav_link 'New Page'
    end
  end

  context 'as an admin' do
    
    before :each do
      sign_in(owner.email, 'password')     
    end

    it 'should create successfully' do

      create_page(world, 'Test Page')

      expect(page).to have_title 'Test Page'
    end

    it 'should get an error for repeated names' do
      create(:page, title: 'repeat', sub_wiki: world.sub_wiki)

      create_page(world, 'repeat')

      expect(page).to have_error_explanation 'title already exists'
    end

    it 'should get an error for blank names' do
      create_page(world, '')

      expect(page).to have_error_explanation "title can't be blank"
    end

    it 'can preview the new page' do
      visit user_world_path(world.name)

      click_on 'New Page'
  
      fill_in 'page_title', with: 'Preview page'
      click_on 'Preview'

      expect(page).to have_title 'Preview page-Preview'

      first(:link, 'Return to create').click
      click_on 'Create!'

      expect(page).to have_title 'Preview page'
    end

  end
end