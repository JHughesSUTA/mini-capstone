class Product < ApplicationRecord 
  belongs_to :supplier, optional: true
  has_many :images
  has_many :orders, through: :carted_products
  has_many :carted_products
  has_many :category_products
  has_many :categories, through: :category_products

  validates :name, :price, :description, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: true
  validates :description, length: { maximum: 500 }

  def sale_message 
    if price.to_f < 100
      "Discount Item!"
    else
      "Everyday Value!!"
    end
  end

  def tax
    tax = (price.to_f * 0.09).round(2)
  end

  def total
    total = price.to_f + tax
  end

end
