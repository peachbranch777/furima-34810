class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :description
    validates :price, inclusion: { in: 300..9999999 }, format: {with: /\A[0-9]+\z/}, numericality: true
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :delivery_day_id
    validates :prefecture_id
    validates :image
  end



  has_one_attached :image
  belongs_to :user
  has_one :order
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :delivery_day
  belongs_to :prefecture

  validates :category_id, :condition_id, :delivery_charge_id, :delivery_day_id, :prefecture_id, numericality: { other_than: 1 }

end
