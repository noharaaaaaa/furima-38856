class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(items_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def index
    @items = Item.order("created_at DESC")
  end

  private

  def items_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_id, :price, :image).
    merge(user_id: current_user.id)
  end

end
