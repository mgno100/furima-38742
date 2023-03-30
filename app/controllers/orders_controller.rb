class OrdersController < ApplicationController

  def index
    @order_residence = OrderResidence.new
  end
end
