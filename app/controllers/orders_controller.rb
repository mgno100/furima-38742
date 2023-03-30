class OrdersController < ApplicationController

  def index
    @order_residence = OrderResidence.new
  end

  def create
    @order_residence = OrderResidence.new(order_params)
    if @order_residence.valid?
      @order_residence.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_residence).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
