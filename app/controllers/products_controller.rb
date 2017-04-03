class ProductsController < ApplicationController 
  before_action :authenticate_admin!, except: [:index, :show]

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
    @product = Product.new
    render "new.html.erb"
  end

  def create
    @product = Product.new(
      name: params[:form_name],
      price: params[:form_price],
      # image: params[:form_image],
      description: params[:form_description]
    )
    if @product.save
      image = Image.new(
        url: params[:form_image],
        product_id: @product.id 
      )
      image.save
      flash[:success] = "Product Created"   
      redirect_to "/products/#{@product.id}"
    else
      render "new.html.erb"
    end
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
    @product = Product.find_by(id: params[:id])
    if @product.update(
      name: params[:form_name],
      price: params[:form_price],
      description: params[:form_description]
    )
      flash[:success] = "Product Updated"
      redirect_to "/products/#{@product_id}"
    else 
      render "edit.html.erb"
    end
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
