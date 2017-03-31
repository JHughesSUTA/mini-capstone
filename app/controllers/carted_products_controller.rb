class CartedProductsController < ApplicationController 
  before_action :authenticate_user!
  
  def index
    @carted_products = current_user.carted_products.where(status: "carted")
    
    if @carted_products.length > 0 
      render "index.html.erb"
    else
      flash[:warning] = "You have no items in your cart"
      redirect_to "/"
    end
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

  def destroy
    carted_product = CartedProduct.find_by(id: params[:id])
    carted_product.status = "removed"
    carted_product.save 
    flash[:success] = "Item removed"
    redirect_to "/checkout"
  end
end
