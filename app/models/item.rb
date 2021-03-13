class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :category_id
    validates :condition_id
    validates :delivery_carge_id
    validates :delivery_day_id
    validates :prefecture_id
  end

  has_one_attached :image
  belongs_to :user
  has_one :order

end
