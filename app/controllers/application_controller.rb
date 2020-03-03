class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end

  def enhanced_order(id)
    # records_array = ActiveRecord::Base.connection.execute("SELECT image, order_id, line_items.quantity, total_price_cents, name, description FROM products JOIN line_items ON products.id = line_items.product_id WHERE order_id = 6")    
    # @order_items = Product.joins(:line_items).where("line_items.order_id = 3").map {|product| {product:product}}
    # Using select seems to stop rails from being able to find images. Tried for 2 hours to do this with one query. Extremely useful rails, 10/10, great job
    order_products = Product.joins(:line_items).where("line_items.order_id = ?", id)
    order_info = LineItem.where("order_id = ?", id)
    order_products.map.with_index {|product, index| [product, order_info[index]]}
    # LineItem.joins(:products).where("order_id=3").select("products.name, line_items.*")
  end

  helper_method :enhanced_order

  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

end
