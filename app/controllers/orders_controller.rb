class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index,:create]
  before_action :move_to_root, only: [:index, :create]
  before_action :item_id, only: [:index, :create]
  def index
    @order_information = OrderInformation.new
  end

  def create
    @order_information = OrderInformation.new(order_params)
    if @order_information.valid?
      @order_information.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def order_params
    params.require(:order_information).permit(:post_code, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def item_id
    @item = Item.find(params[:item_id])
  end

  def move_to_root
    if current_user.id == item_id.user_id
      redirect_to root_path
    end
  end
end
