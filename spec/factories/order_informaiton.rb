FactoryBot.define do
  factory :order_information do
    post_code {"123-4567"}
    prefecture_id {2}
    city {"横浜"}
    block {"小倉1-2"}
    phone_number {"12345678901"}
    token {"1234567899191"}
    user_id {1}
    item_id {1}
  end
end