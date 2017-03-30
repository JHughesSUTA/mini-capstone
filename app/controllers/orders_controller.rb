class OrdersController < ApplicationController 
  def create
    carted_products = current_user.carted_products.where(status: "carted")

    subtotal = 0
    tax = 0
    carted_products.each do |carted_product|
      subtotal += (carted_product.product.price * carted_product.quantity)
      tax += (carted_product.product.tax * carted_product.quantity) 
    end

    total = subtotal + tax

    order = Order.new(
      subtotal: subtotal,
      tax: tax,
      total: total,
      user_id: current_user.id
    )
    #order.calculate_totals
    order.save
    
    carted_products.each do |carted_product|
      carted_product.status = "purchased"
      carted_product.order_id = order.id
      carted_product.save
    end

    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find_by(id: params[:id])
    render "show.html.erb"
  end
end
