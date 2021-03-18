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
        @item.price = 301
        expect(@item).to be_valid
      end
      it 'priceの値が半角数字であれば、出品できる' do
        @item.price = 777
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '写真がない時出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "出品画像を入力してください"
      end
      it '商品名がない時出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品名を入力してください"
      end
      it '商品の説明がない時出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の説明を入力してください"
      end
      it 'カテゴリーがない時出品できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーを入力してください"
      end
      it 'conditionがない時出品できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態を入力してください"
      end
      it 'delivery_charge_idがない時出品できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料を入力してください"
      end
      it 'delivery_day_idがないと出品できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数を入力してください"
      end
      it 'prefecture_idがないと出品できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域を入力してください"
      end
      it 'priceがないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格を入力してください"
      end
      it 'priceの値が1~299の時出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は一覧にありません"
      end
      it 'priceの値が10000000以上の時出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は一覧にありません"
      end
      it 'priceの値が全角数字の時出品できない' do
        @item.price = "１１１１"
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は一覧にありません"
      end
      it 'priceが英数混合では出品できない' do
        @item.price = "1234aaaaa"
        @item.valid?
        expect(@item.errors.full_messages).to include "販売価格は数値で入力してください"
      end
      it 'category_idが1の時出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "カテゴリーは1以外の値にしてください"
      end
      it 'condition_idが1の時出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "商品の状態は1以外の値にしてください"
      end
      it 'delivery_charge_idが1の時出品できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "配送料は1以外の値にしてください"
      end
      it 'delivery_day_idが1の時出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "発送までの日数は1以外の値にしてください"
      end
      it 'prefecture_idが1の時出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "発送元の地域は1以外の値にしてください"
      end
    end
  end
end
