require 'rails_helper'

describe 'Creating a Template' do
  let(:user) { create(:user) }

  context 'when not logged in' do
    it 'should not be possible' do
      visit root_path

      expect(page).not_to have_css 'a', text: 'New Template'
    end
  end

  context 'when logged in' do
    
    before :each do
      sign_in(user.email, 'password')
    end

    it 'should succeed' do
      visit root_path

      click_on 'New Template'

      fill_in 'page_title', with: 'template'
      click_on 'Create!'

      expect(page).to have_title 'Template: template'
    end
  end
end