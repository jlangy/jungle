require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    User.new(
      first_name:"Toothpaste",
      last_name: 'Colgate', 
      password: '123',
      password_confirmation: '123',
      email: "a@b.com"
    )}
  describe "Validations" do 
    it "requires a password" do
      subject.password = nil;
      expect(subject).to be_invalid
    end
    
    it "requires a password of length 3+" do
      subject.password = '12';
      subject.password_confirmation = '12';
      expect(subject).to be_invalid
    end
    
    it "requires a password confirmation" do
      subject.password_confirmation = nil;
      expect(subject).to be_invalid
    end

    it "requires a email" do
      subject.email = nil;
      expect(subject).to be_invalid
    end
    
    it "requires a unique email" do
      user_with_duplicate_email = subject.dup;
      user_with_duplicate_email.save;
      expect(subject).to be_invalid
    end

    it "has case insensitive email field" do
      user_with_duplicate_email = subject.dup;
      user_with_duplicate_email.save;
      subject.email = 'A@b.com'
      expect(subject).to be_invalid
    end

    it "requires a first_name" do
      subject.first_name = nil;
      expect(subject).to be_invalid
    end

    it "requires a last_name" do
      subject.last_name = nil;
      expect(subject).to be_invalid
    end

    it "Is not valid with bad password confirmation" do
      subject.password_confirmation = '1234';
      expect(subject).to be_invalid
    end

    it "Is valid with matching password and confirmation" do
      expect(subject).to be_valid
    end  
  end

  describe '.authenticate_with_credentials' do
    it 'authenticates a valid user' do
      subject.save
      expect(User.authenticate_with_credentials('a@b.com','123')).to be_present
    end

    it 'authenticates a valid user with differently cased email' do
      subject.save
      expect(User.authenticate_with_credentials('A@B.com','123')).to be_present
    end
    
    it 'authenticates a valid user with spaced email' do
      subject.save
      expect(User.authenticate_with_credentials('   A@B.com  ','123')).to be_present
    end

    it "doesn't authenticate invalid users" do
      expect(User.authenticate_with_credentials('a@b.com','123')).to_not be_present
    end
  end
end
