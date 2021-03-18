require 'rails_helper'

RSpec.describe OrderInformation, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_information = FactoryBot.build(:order_information, user_id: @user.id, item_id: @item.id)
    sleep 0.1
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
      it 'buildingが存在しなくても購入できる' do
        @order_information.building = ""
        expect(@order_information).to be_valid
      end

    end
    context '購入できない時' do
      it 'user_idがない時' do
        @order_information.user_id = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Userを入力してください"
      end
      it 'item_idが空の時' do
        @order_information.item_id = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "Itemを入力してください"
      end
      it 'post_codeが空の時' do
        @order_information.post_code = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "郵便番号を入力してください"
      end
      it 'post_codeにハイフンがない時' do
        @order_information.post_code = "1234567"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "郵便番号は不正な値です"
      end
      it 'post_codeの数字が7つない時' do
        @order_information.post_code = "123-456"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "郵便番号は不正な値です"
      end
      it 'prefecutre_idがない時' do
        @order_information.prefecture_id = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "都道府県を入力してください"
      end
      it 'prefecture_idが1の時' do
        @order_information.prefecture_id = 1
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "都道府県は1以外の値にしてください"
      end
      it 'cityが空の時' do
        @order_information.city = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "市町村を入力してください"
      end
      it 'blockがない時' do
        @order_information.block = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "番地を入力してください"
      end
      it 'phone_numberがない時' do
        @order_information.phone_number = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "電話番号を入力してください"
      end
      it 'phone_numberが12桁以上の時' do
        @order_information.phone_number = "123456789088"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'phone_numberが英数混合では登録できないこと' do
        @order_information.phone_number = "12345678oo"
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "電話番号は不正な値です"
      end
      it 'tokenが空の時' do
        @order_information.token = ""
        @order_information.valid?
        expect(@order_information.errors.full_messages).to include "クレジットカード情報を入力してください"
      end
    end
  end
end