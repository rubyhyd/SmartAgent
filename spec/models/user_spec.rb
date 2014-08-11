require "spec_helper"

describe User do

  context "RESPOND TO" do
    let(:user) { create :user }
    subject {user}

    it { should be_valid }
    it { should respond_to :email }
    it { should respond_to :password_digest }
    it { should respond_to :password }
    it { should respond_to :password_confirmation }
    it { should respond_to :authenticate }
  end

  context "VALIDATIONS" do
    let(:user) { build :user }

    it "is invalid when email is blank" do
      user.email = nil 
      expect(user).to have(1).errors_on(:email)
    end

    it "is invalid when email is wrong formatted" do
      invalid_email = %w[asdf 1234 asdf234 @asdf1 asdf23@ @]
      invalid_email.each do |email|
        user.email = email
        expect(user).to have(1).errors_on(:email)
      end
    end

    it "is invalid without a password" do
      user.password = nil
      expect(user).to have(1).errors_on(:password)
    end

    it "is invalid without a password_confirmation" do
      user.password_confirmation = nil
      expect(user).to have(1).errors_on(:password_confirmation)
    end

    it "is invalid when two users have the same email" do
      new_user = user.dup
      user.save
      expect(new_user).to have(1).errors_on(:email)
    end

    it "is invalid when password and confirmation are different" do
      user.password_confirmation = "invalid"
      expect(user).to_not be_valid        
    end
  end

  context "BUSINESS" do
    let(:user) { create :user }  
    let(:user_found) { User.find_by(email: user.email)}

    subject {user}

    it { should eq user_found.authenticate(user.password)}

    it { should_not eq user_found.authenticate("mismatch") }

    #need a not found test
  end
end
