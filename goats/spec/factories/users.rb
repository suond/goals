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

FactoryBot.define do
  factory :user do
    email { Faker::Movies::StarWars.character }
    password { "starwars" }
  end

  factory :user_fk do
    email {"fake_email"}
    password {"123456"}
  end
end
