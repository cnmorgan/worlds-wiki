require 'rails_helper'

describe 'Editing a Template' do
  let(:user) { create(:user) }
  let(:template) { create(:template, user: user) }

  context 'when not logged in' do
    it 'should not be possible' do
      visit user_template_path(user.username, template.title)

      expect(page).to have_alert "You don't have permission to do that"
    end
  end

  context 'when logged in' do
    
    before :each do
      sign_in(user.email, 'password')
    end

    it 'should succeed' do
      visit user_template_path(user.username, template.title)

      click_on 'Edit Template'

      fill_in 'page_edit_title', with: 'edited'
      click_on 'Update!'

      expect(page).to have_title 'Template: edited'
    end
  end
end