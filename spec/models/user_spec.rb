require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save if all required fields are valid' do
      user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
      user.save!
      expect(User.find_by(email: 'john@smith.com')).to eql(user)
    end

    it 'should fail to save with no password' do
      user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password_confirmation: 'jonny')
      user.save

      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should fail to save with no password confirmation' do
      user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny')
      user.save

      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should fail to save if password and confirmation do not match' do
      user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny5')
      user.save

      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should fail to save if password is shorter than 3 characters' do
      user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jo', password_confirmation: 'jo')
      user.save

      expect(user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
  end
end
