class OrdersController < ApplicationController
  def create
    order = Order.new(
      quantity: params[:quantity], 
      product_id: params["product_id"],
      user_id: current_user.id
    )
    order.calculate_totals
    order.save
    redirect_to "/orders/#{order.id}"
    # @product = Product.find_by(id: params["product id"])
    # quantity=params[:quantity]
    # @order = Order.new(
    #   quantity: params[:quantity],
    #   user_id: current_user.id,
    #   product_id: params["product id"],
    #   subtotal: @product.price * quantity.to_i,
    #   tax: @product.price * quantity.to_i * 0.09,
    #   total: (@product.price * quantity.to_i) * 1.09
    # )
    # @order.save
    # render "show.html.erb"
  end

  def show
    @order = Order.find_by(id: params[:id])
    render "show.html.erb"
  end
end
