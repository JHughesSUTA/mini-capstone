class Product < ApplicationRecord
  belongs_to :supplier
  has_many :images

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
