class ProductsController < ApplicationController 
  def index

    if params[:discounted] == "true"
      @products = Product.where("price < ?", 10)
    elsif params[:category]
      category = Category.find_by(name: params[:category])
      @products = category.products
    else
      sort_attribute = params[:sort_by] || "id"
      @products = Product.all.order(sort_attribute)
    end
    render "index.html.erb"
  end

  def new
    render "new.html.erb"
  end

  def create
    product = Product.new(
      name: params[:form_name],
      price: params[:form_price],
      image: params[:form_image],
      description: params[:form_description]
    )
    product.save
    image = Image.new(
      url: params[:image],
      product_id: @product.id 
    )
    image.save
    render "create.html.erb"
  end

  def show
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render "show.html.erb"
  end

  def edit
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    render "edit.html.erb"
  end

  def update
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @product.name = params[:form_name]
    @product.price = params[:form_price]
    @product.description = params[:form_description]
    @product.save
    flash[:success] = "Product Updated"
    redirect_to "/products/#{product_id}"
  end

  def destroy
    product_id = params[:id]
    @product = Product.find_by(id: product_id)
    @product.destroy
    flash[:danger] = "Product deleted"
    redirect_to "/products"
  end

  def discounted
    sort_attribute = params[:sort_by] || "id"
    @products = Product.where("price < ?", 100)
    render "discounted.html.erb"
  end
end
