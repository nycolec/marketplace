FactoryBot.define do
  factory :purchase do
    association :produce
    association :seller
    association :buyer
    status { 'completed' }
    date_purchased { 1.day.ago }
    
    trait :cancelled_purchase do
      status { 'cancelled' }
    end
  end
end

def buyer_with_purchases(purchase_count: 5, purchases_time_distance: {from: 14.days.ago, to: Time.now}, **traits)
  FactoryBot.create(:buyer) do |buyer|
    FactoryBot.build_list(:purchase, purchase_count, { buyer: }.merge(traits)) do |record|
      record.date_purchased = Faker::Time.between(from: purchases_time_distance[:from], to: purchases_time_distance[:to])
      record.save!
    end
  end
end