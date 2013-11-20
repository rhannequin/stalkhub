FactoryGirl.define do
  factory :stalking do |f|
    f.owner "rhannequin"
    f.repo  "stalkhub"
  end

  factory :invalid_stalking, parent: :stalking do |f|
    f.owner { Faker::Lorem.characters(6) }
    f.repo  { Faker::Lorem.characters(6) }
  end
end
