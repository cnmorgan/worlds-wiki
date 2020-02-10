require 'rails_helper'

RSpec.describe World, type: :model do

  it 'should validate name presence' do
    world = build(:world, name: nil)

    expect(world).not_to be_valid

    world = build(:world, name: 'valid name')

    expect(world).to be_valid
  end

  it 'should validate name uniqueness' do
    create(:world, name: 'repeated name')
    world = build(:world, name: 'repeated name')

    expect(world).not_to be_valid
  end

  it 'should make the owner an admin by default' do
    user = create(:user)
    world = create(:world, owner: user)

    expect(world.is_admin?(user)).to be true
  end

  it 'should create a sub wiki on save' do
    world = create(:world)

    expect(world.sub_wiki).not_to be_nil
  end

  describe '#make_admin' do
    it 'should make a user an admin' do
      world = create(:world)
      user = create(:user)
      
      world.make_admin(user)

      expect(world.is_admin?(user)).to be true
    end
  end

end
