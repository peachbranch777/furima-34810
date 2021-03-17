require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品購入機能' do
    context '購入できる時' do
      it 'user_idがある時' do
        expect(@order).to be_valid
      end
      it 'item_idがある時' do
        expect(@order).to be_valid
      end
    end
    context '購入できない時' do
      it 'user_idがない時' do
        @order.user_id = nil
        @order.valid?
        binding.pry
        expect(@order.errors.full_messages).to include
      end
    end
  end
end
