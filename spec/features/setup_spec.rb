require 'rails_helper'

describe 'test suite setup' do
  it 'should generate Worlds Wiki world' do
    world = World.find_by(name: 'Worlds Wiki')

    expect(world).not_to be_nil
  end

  it 'should generate welcome' do
    world = World.find_by(name: 'Worlds Wiki')
    page = world.sub_wiki.pages.find_by(title: 'Welcome')

    expect(page).not_to be_nil
  end
end