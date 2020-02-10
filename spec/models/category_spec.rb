require 'rails_helper'

RSpec.describe Category, type: :model do
  
  let(:sub_wiki) {create(:world).sub_wiki}

  it 'should validate name presence' do
    cat = build(:category, name: nil, sub_wiki: sub_wiki)

    expect(cat).not_to be_valid

    cat = build(:category, name: 'valid', sub_wiki: sub_wiki)

    expect(cat).to be_valid
  end

end
