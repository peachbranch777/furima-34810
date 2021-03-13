require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe "出品機能" do
    context "出品できる時" do
      it 'name, description, price, category_id, condition_id, delivery_charge_id, delivery_day_id, prefecture_id, image全て存在すれば、出品できる' do
        expect(@item).to be_valid
      end
      it 'priceの値が300~9999999の間であれば出品できる' do
        @item.price = "301"
        expect(@item).to be_valid
      end
      it 'priceの値が半角数字であれば、出品できる' do
        @item.price = "777"
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '写真がない時出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it '商品名がない時出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Name can't be blank"
      end
      it '商品の説明がない時出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it 'カテゴリーがない時出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'conditionがない時出品できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Condition can't be blank"
      end
      it 'delivery_charge_idがない時出品できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery charge can't be blank"
      end
      it 'delivery_day_idがないと出品できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery day can't be blank"
      end
      it 'prefecture_idがないと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'priceがないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceの値が1~299の時出品できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not included in the list"
      end
      it 'priceの値が10000000以上の時出品できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not included in the list"
      end
      it 'priceの値が全角数字の時出品できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not included in the list"
      end
    end
  end
end
