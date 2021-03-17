require 'rails_helper'

RSpec.describe Information, type: :model do
  before do
    @information = FactoryBot.build(:information)
  end

  describe "商品購入機能" do
    context '購入できる時' do
      it 'post_codeにハイフンある時' do
        expect(@information).to be_valid
      end
    end
  end
end
