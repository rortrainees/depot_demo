class Order < ActiveRecord::Base
 PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
 belongs_to :cart

  has_many :transactions, :class_name => "OrderTransaction"
#----------check validation------------------#
 validates :first_name, :address, :email,:presence => true
   
#---------------associations----------------#
 has_many :line_items ,:dependent => :destroy

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  ## active merchant ---##
  attr_accessor :card_number, :card_verification
  validate(:validate_card , :on => :create)
  
  
  def purchase
    price_in_cents = 1000
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount =>price_in_cents, :response => response)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
  
  #def price_in_cents
  #  (cart.total_price*100).round
  #end
  def total_price 
    line_items.to_a.sum { |item| item.total_price}
  end
  def total_items
	   line_items.sum(:quantity)
	end

  private
  
  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => "Ryan Bates",
        :address1 => "123 Main St.",
        :city     => "New York",
        :state    => "NY",
        :country  => "US",
        :zip      => "10001"
      }
    }
  end
  
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
   
  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => "asdf"
    )
  end
end
