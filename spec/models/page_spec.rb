require 'rails_helper'

RSpec.describe Page, type: :model do

  let(:sub_wiki) {create(:world).sub_wiki}

  it 'should validate title prescence' do
    page = build(:page, title: nil, sub_wiki: sub_wiki)

    expect(page).not_to be_valid

    page = build(:page, title: 'valid page', sub_wiki: sub_wiki)

    expect(page).to be_valid
  end

  it 'should validate title uniqueness' do
    create(:page, title: 'repeated', sub_wiki: sub_wiki)
    page = build(:page, title: 'repeated', sub_wiki: sub_wiki)

    expect(page).not_to be_valid
  end
end
