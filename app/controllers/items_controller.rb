class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :item_id, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :move_to_root, only: [:edit]
  def index
    @item = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :condition_id, :delivery_charge_id, :delivery_day_id, :prefecture_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    if current_user.id != @item.user.id
      redirect_to action: :index
    end
  end

  def item_id
    @item = Item.find(params[:id])
  end

  def move_to_root
    current_user.id == @item.user.id && @item.order.present?
    redirect_to root_path
  end
end
