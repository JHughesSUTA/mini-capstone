class CartedProductsController < ApplicationController 
  def index
    @carted_products = current_user.carted_products.where(status: "carted")
    render "index.html.erb"
  end

  def create
    carted_product = CartedProduct.new(
      quantity: params[:quantity], 
      product_id: params["product_id"],
      user_id: current_user.id,
      status: "carted"
    )
    # order.calculate_totals
    carted_product.save
    redirect_to "/checkout"
  end
end
