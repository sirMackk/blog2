FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "bob#{n}@example.com" }
    password        "bob1"
    username        "bob"

    factory :admin do
      role          "admin"
    end
  end

  factory :post do
    sequence(:title) { |n| "title-#{n}" }
    description     "A Description"
    body            "Body" + "body " * 100
    user

    trait :with_comments do
      after(:create) do |post|
        2.times do
          post.comments << create(:comment, post_id: post)
        end
      end
    end
  end
  
  factory :comment do
    sequence(:email) { |n| "joe#{n}@example.com" }
    nick            "Joe"
    body            "Comment" + "body " * 25
  end
end
