class OrdersController < ApplicationController
  before_action :order_item, only: [:index, :create]
  before_action :user_item, only: [:index]

  def index
    @order_address = OrderAddress.new
    if user_signed_in?
      render :index
    else
      render template: "devise/sessions/new"
    end
  end

  def create
    @order_address = OrderAddress.new(address_params)
    if @order_address.valid? 
      @order_address.save
      pay_item
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency:'jpy'
    )
 end

 def address_params
  params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :tel).merge(token: params[:token], item_id: @item.id, user_id: current_user.id)
 end

 def order_item
    @item = Item.find(params[:item_id])
 end

 def user_item
   @item = Item.find(params[:item_id])
   if @item.user_id == current_user.id || @item.order
    redirect_to root_path
   end
 end

end
