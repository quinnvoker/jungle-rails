require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save if all required fields are valid' do
      user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
      user.save!
      expect(User.find_by(email: 'john@smith.com')).to eql(user)
    end

    describe 'Password' do
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

    describe 'Email' do
      it 'should fail to save with no email' do
        user = User.new(first_name: 'John', last_name: 'Smith', password: 'jonny', password_confirmation: 'jonny')
        user.save
  
        expect(user.errors.full_messages).to include("Email can't be blank")
      end

      it 'should fail to save if user with email already exists (case insensitive)' do
        user = User.new(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
        user.save
  
        user_copy = User.new(first_name: 'John', last_name: 'Smith', email: 'joHn@smith.com', password: 'jonny', password_confirmation: 'jonny')
        user_copy.save
  
        expect(user_copy.errors.full_messages).to include("Email has already been taken")
      end
    end

    describe 'Names' do
      it 'should fail to save with no first name' do
        user = User.new(last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
        user.save
  
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'should fail to save with no last name' do
        user = User.new(first_name: 'John', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
        user.save
  
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return the user when given valid email and passord' do
      user = User.create(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
      
      authenticated = User.authenticate_with_credentials('john@smith.com', 'jonny')

      expect(authenticated).to eql(user)
    end

    it 'should return nil if given invalid email and password combination' do
      user = User.create(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
      
      authenticated = User.authenticate_with_credentials('john@smith.com', 'jony')

      expect(authenticated).to be nil
    end

    it 'should ignore whitespace before and after email' do
      user = User.create(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
      
      authenticated = User.authenticate_with_credentials(' john@smith.com  ', 'jonny')

      expect(authenticated).to eql(user)
    end

    it 'should ignore case of email' do
      user = User.create(first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'jonny', password_confirmation: 'jonny')
      
      authenticated = User.authenticate_with_credentials('john@SMITH.com', 'jonny')

      expect(authenticated).to eql(user)
    end
  end
end
