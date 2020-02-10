require 'rails_helper'

RSpec.describe User, type: :model do

  it 'should validate email format' do
    user = build(:user, email: 'invalid')
    expect(user).not_to be_valid

    user = build(:user, email: 'still@invalid')
    expect(user).not_to be_valid

    user = build(:user, email: 'valid@email.com')
    expect(user).to be_valid
  end

  it 'should validate email uniqueness' do
    create(:user, email: 'repeated@email.com')
    user = build(:user, email: 'repeated@email.com')

    expect(user).not_to be_valid
  end

  it 'should validate username presence' do
    user = build(:user, username: nil)
    expect(user).not_to be_valid

    user = build(:user)
    expect(user).to be_valid
  end

  it 'should validate username uniqueness' do
    create(:user, username: 'repeated_username')
    user = build(:user, username: 'repeated_username')

    expect(user).not_to be_valid
  end

  it 'should validate password presence' do
    user = build(:user, password: nil)

    expect(user).not_to be_valid
  end

  it 'should validate password confirmation matches password' do
    user = build(:user, password: 'password', password_confirmation: 'not_password')

    expect(user).not_to be_valid
  end

end
