class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :item_find, only: [:show, :edit, :update, :destroy]

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

  def show
  end

  def edit
    redirect_to action: :index if current_user.id != @item.user_id
  end

  def update
    if @item.update(items_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    if current_user.id == @item.user_id
      @item.destroy
      redirect_to action: :index
    else
      redirect_to action: :index
    end
  end

  private

  def items_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :delivery_fee_id, :prefecture_id, :days_id, :price, :image).
    merge(user_id: current_user.id)
  end

  def item_find
    @item = Item.find(params[:id])
  end

end
