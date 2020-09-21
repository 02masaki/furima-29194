class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
    if user_signed_in?
      render :index
    else
      render template: "devise/sessions/new"
    end
  end

  def create
    @item = Item.find(params[:item_id])
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

end
