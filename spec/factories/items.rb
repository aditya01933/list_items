FactoryGirl.define do
  factory :item do
    title Faker::Name.first_name + Random.new.rand(2).to_s
  end
end
