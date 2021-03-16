require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    @order_information = FactoryBot.build(:order_information)
  end

  describe '商品購入機能' do
    context '購入できる時' do
      it 'post_code, prefecture_id, city, block, phone_number, user_id, item_id, token全て存在する時' do
        expect(@order_information).to be_valid
      end
      it '郵便番号にハイフンがある時' do
        @order_information.post_code = "123-4567"
        expect(@order_information).to be_valid
      end
      it '電話番号が数字11桁の時' do
        @order_information.phone_number = "12345678901"
        expect(@order_information).to be_valid
      end

    end
    context '購入できない時' do
      it 'user_idがない時' do
        @order_information.user_id = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "User can't be blank"
      end
      it 'item_idが空の時' do
        @order_information.item_id = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Item can't be blank"
      end
      it 'post_codeが空の時' do
        @order_information.post_code = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Post code can't be blank"
      end
      it 'post_codeにハイフンがない時' do
        @order_information.post_code = "1234567"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Post code is invalid"
      end
      it 'post_codeの数字が7つない時' do
        @order_information.post_code = "123-456"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Post code is invalid"
      end
      it 'prefecutre_idがない時' do
        @order_information.prefecture_id = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'prefecture_idが1の時' do
        @order_information.prefecture_id = 1
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Prefecture must be other than 1"
      end
      it 'cityが空の時' do
        @order_information.city = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "City can't be blank"
      end
      it 'blockがない時' do
        @order_information.block = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Block can't be blank"
      end
      it 'phone_numberがない時' do
        @order_information.phone_number = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Phone number can't be blank"
      end
      it 'phone_numberが11桁ない時' do
        @order_information.phone_number = "1234567890"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Phone number is invalid"
      end
      it 'tokenが空の時' do
        @order_information.token = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Token can't be blank"
      end
    end
  end
end