FactoryGirl.define do
  factory :product do
    association(:category)
    sequence(:name) { |i| "product#{i}"}
    price 10
    sale "sale"
    author "author"
    series "series"
    ISBN "isnb"
    url "url"
    producer "producer"
    picture "picture"
    description "description"
    md5 "md5"
    cover "cover"
  end
end
