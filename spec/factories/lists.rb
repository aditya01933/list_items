FactoryGirl.define do
  factory :list do
    title Faker::Name.first_name + Random.new.rand(2).to_s
  end
end
