class OrdersController < ApplicationController 
  def create
    carted_products = current_user.carted_products.where(status: "carted")

    subtotal = 0
    tax = 0
    carted_products.each do |product|
      subtotal = subtotal + product.price
      tax = tax + product.tax
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
    carted_products.status = ""
    redirect_to "/orders/#{order.id}"
  end

  def show
    @order = Order.find_by(id: params[:id])
    render "show.html.erb"
  end
end
