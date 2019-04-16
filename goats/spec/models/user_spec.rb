# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email)                  }
  # it { should validate_presence_of(:session_token)          }
  it { should validate_presence_of(:password_digest)        }
  it { should validate_length_of(:password).is_at_least(6)  }

  

  describe '::find_by_credential' do 
    it 'should find the user given a password and email' do
      User.create!(email: "fake_email", password: "123456")
      us = User.find_by_credentials("fake_email", "123456")
      expect(us).not_to be_nil
    end
  end

  # describe "#is_password" do
  #   let(:user) { FactoryBot.build(:user) }

  #   context 'with an invalid password' do
  #     it 'should return false' do
  #       expect(user.is_password?('startrek')).to be_false
  #     end
  #   end

  #   context 'with a valid password' do
  #     it 'should return true' do
  #       expect(user.is_password?('starwars')).to be_true
  #     end
  #   end



  # end
end
