require 'bigdecimal'
require 'bigdecimal/util'

class Product
  attr_accessor :name, :price, :discount
  def initialize(product_name, price, discount = {})
    @name = product_name
    @price = price
    initialize_discount(discount) if discount.length > 0
  end
 
  private
  def initialize_discount(discount)
    if discount[:get_one_free]
      @discount = GetOneFreeDiscount.new(discount[:get_one_free])
    elsif discount[:package]
      @discount = PackageDiscount.new(discount[:package])
    elsif discount[:threshold]
      @discount = ThresholdDiscount.new(discount[:threshold])
    end
  end
  
  def calculate_price(quantity)
    @price.to_d * quantity
  end
  
  def calculate_discount(quantity)
    @discount ? @discount.calculate_discount(@price, quantity) : 0
  end
  
  public
  def hash
    @name.hash
  end
  
  def eql?(other)
    @name.eql? other.name
  end
  
  def total_price(quantity)
    calculate_price(quantity) - calculate_discount(quantity)
  end
  
  def print(quantity)
    product_price = calculate_price(quantity)
    product_inv = "\n| %-38s %7s |%9.2f |" % [@name, quantity, product_price]
    if @discount
      product_inv += @discount.print(@price, quantity)
    end
    product_inv
  end
end

class GetOneFreeDiscount
  def initialize(discount)
    @get_one_free = discount
  end

  def calculate_discount(product_price, quantity)
    (quantity / @get_one_free) * product_price.to_d
  end
  
  def print(product_price, quantity)
    discount_calc = calculate_discount(product_price, quantity)
    if discount_calc > 0
      discount_text = "(buy #{@get_one_free - 1}, get 1 free)"
      discount_neg = '-'.concat(discount_calc.to_s)
      "\n|   %-45s|%9.2f |" % [discount_text, discount_neg]
    else
      ""
    end
  end
end

class PackageDiscount
  def initialize(discount)
    @package = discount.keys[0]
    @percent = discount.values[0]
  end

  def calculate_discount(product_price, quantity)
    (quantity / @package) * @package * product_price.to_d * @percent / 100
  end
  
  def print(product_price, quantity)
    discount_calc = calculate_discount(product_price, quantity)
    if discount_calc > 0 
      discount_text = "(get #{@percent}% off for every #{@package})"
      discount_neg = '-'.concat(discount_calc.to_s)
      "\n|   %-45s|%9.2f |" % [discount_text, discount_neg]
    else
      ""
    end
  end
end

class ThresholdDiscount
  def initialize(discount)
    @amount = discount.keys[0]
    @percent = discount.values[0]
  end

  def calculate_discount(product_price, quantity)
    if (quantity > @amount)
      (quantity - @amount) * product_price.to_d * @percent / 100
    else
      0
    end
  end
  
  def print(product_price, quantity)
    discount_calc = calculate_discount(product_price, quantity)
    if discount_calc > 0 
      discount_text = "(#{@percent}% off of every after the #{amount_words})"
      discount_neg = '-'.concat(discount_calc.to_s)
      "\n|   %-45s|%9.2f |" % [discount_text, discount_neg]
    else
      ""
    end
  end

  def amount_words
    if (@amount == 1)
      "1st"
    elsif (@amount == 2)
      "2nd"
    elsif (@amount == 3)
      "3rd"
    else
      "#{@amount}th"
    end
  end
end

class AmountCoupon
  attr_accessor :name
  def initialize(coupon_name, discount)
    @name = coupon_name
    @amount = discount.kind_of?(String) ? discount.to_d : discount
  end
  
  def calculate_discount(price)
    @amount < price ? @amount : price
  end
  
  def print(price)
    coupon_discount = calculate_discount(price)
    discount_text = "Coupon %s - %.2f off" % [@name, @amount]
    discount_neg = '-'.concat(coupon_discount.to_s)
    "\n| %-46s | %8.2f |" % [discount_text, discount_neg]
  end
end

class PercentCoupon
  attr_accessor :name
  def initialize(coupon_name, discount)
    @name = coupon_name
    @percent = discount
  end
  
  def calculate_discount(price)
    price * @percent / 100
  end
  
  def print(price)
    coupon_discount = calculate_discount(price)
    discount_text = "Coupon #{@name} - #{@percent}% off"
    discount_neg = '-'.concat(coupon_discount.to_s)
    "\n| %-46s | %8.2f |" % [discount_text, discount_neg]
  end
end

class Inventory
  def initialize
    @products_registered = []
    @coupons_registered = []
  end
  
  def register(product_name, price, discount = {})
    raise "Product name is too long" if product_name.length > 40
    raise "Duplicated product name" if product_registered?(product_name)
    raise "Invalid product price." if price.to_d < 0.01 or price.to_d > 999.99
    @products_registered << Product.new(product_name, price, discount)
  end
  
  def register_coupon(coupon_name, discount)
    raise "Duplicated coupon name" if coupon_registered?(coupon_name)
    if discount[:amount]
      @coupons_registered << AmountCoupon.new(coupon_name, discount[:amount])
    elsif discount[:percent]
      @coupons_registered << PercentCoupon.new(coupon_name, discount[:percent])
    end
  end
  
  def new_cart
    @cart = Cart.new(self)
  end
  
  def product_registered?(product_name)
    @products_registered.any? { |product| product.name == product_name } 
  end
  
  def product_by_name(product_name)
    @products_registered.find(product_name) { |item| item.name == product_name }
  end
  
  def coupon_registered?(coupon_name)
    @coupons_registered.any? { |coupon| coupon.name == coupon_name } 
  end
  
  def coupon_by_name(coupon_name)
    @coupons_registered.find(coupon_name) { |item| item.name == coupon_name }
  end
end

class Cart
  def initialize(inventory)
    @inventory = inventory
    @products_added = {}
  end
  
  private
  def total_products_price
    @products_added.inject(0) do |sum, (product, quantity)|
      sum += product.total_price(quantity)
    end
  end
  
  def total_coupon_discount(price)
    @coupon_used ? @coupon_used.calculate_discount(price) : 0
  end
  
  def build_invoice(total_result, products_price)
    border = "+" + "-" * 48 + "+" + "-" * 10 + "+"
    invoice = border
    invoice += "\n| %-38s %7s |%9s |" % ["Name", "qty", "price"]
    invoice += "\n" + border
    invoice += invoice_rows(products_price)
    invoice += "\n" + border
    invoice += "\n| %-47s|%9.2f |" % ["TOTAL", total_result]
    invoice += "\n" + border + "\n"
  end
 
  def invoice_rows(products_price)
    invoice_rows = @products_added.inject("") do |invoice, (product, quantity)|
      invoice += product.print(quantity)
    end
    if @coupon_used
      invoice_rows += @coupon_used.print(products_price)
    end
    invoice_rows
  end
  
  public
  def add(product_name, quantity = 1)
    unless @inventory.product_registered?(product_name)
      raise "Product #{product_name} doesn't exist in inventory."
    end
    raise "Product quantity 0 or less." if quantity <= 0
    raise "Product quantity greater than 99." if (quantity > 99)
    product = @inventory.product_by_name(product_name)
    @products_added[product] = (@products_added[product] || 0) + quantity
  end
  
  def use(coupon_name)
    unless @inventory.coupon_registered?(coupon_name)
      raise "Coupon #{coupon_name} doesn't exist in inventory."
    end
    @coupon_used = @inventory.coupon_by_name(coupon_name)
  end
  
  def total
    products_price = total_products_price()
    coupon_discount = total_coupon_discount(products_price)
    products_price - coupon_discount
  end
  
  def invoice
    products_price = total_products_price()
    coupon_discount = total_coupon_discount(products_price)
    build_invoice((products_price - coupon_discount), products_price)
  end
end

