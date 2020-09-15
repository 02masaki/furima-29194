class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @items = Item.find(params[:id])
    @user = User.find(@items.user_id)
    @category = Category.find(@items.category_id)
    @status = Status.find(@items.status_id)
    @burden = Burden.find(@items.burden_id)
    @duration = Duration.find(@items.duration_id)
    @prefecture = Prefecture.find(@items.prefecture_id)
  end

  def edit
    @items = Item.find(params[:id])
  end

  def update
    @items = Item.find(params[:id])
    if @items.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  private

  def item_params
    params.require(:item).permit(:name, :price, :content, :category_id, :status_id, :burden_id, :duration_id, :prefecture_id,:image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
