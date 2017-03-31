class OrdersController < ApplicationController 
  before_action :authenticate_user!
  
  def create
    carted_products = current_user.carted_products.where(status: "carted")
    subtotal = 0
    carted_products.each do |carted_product|
      subtotal += (carted_product.product.price * carted_product.quantity)
    end

    tax = subtotal * 0.09
    total = subtotal + tax

    order = Order.new(
      subtotal: subtotal,
      tax: tax,
      total: total,
      user_id: current_user.id
    )
    #order.calculate_totals
    order.save

    # carted_products.each do |carted_product|        this has been refactored using update_all below
    #   carted_product.status = "purchased"
    #   carted_product.order_id = order.id
    #   carted_product.save
    # end
    carted_products.update_all(status: "purchased", order_id: order.id)

    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find_by(id: params[:id])
    render "show.html.erb"
  end
end
