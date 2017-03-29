class CartedProductsController < ApplicationController
  def create
    carted_product = CartedProduct.new(
      quantity: params[:quantity], 
      product_id: params["product_id"],
      user_id: current_user.id,
      status: "carted"
    )
    # order.calculate_totals
    carted_product.save
    redirect_to "/carted_products"
  end
end
