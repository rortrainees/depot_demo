class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  belongs_to :cart
  has_many :transactions, :class_name => "OrderTransaction"
  has_many :line_items ,:dependent => :destroy

  ## active merchant ---##
  attr_accessor :card_number, :card_verification
  validate(:validate_card , :on => :create)
  #validates :first_name, :address, :email,:presence => true
   
  #def add_line_items_from_cart(cart)
  #  cart.line_items.each do |item|
  #   item.cart_id = nil
  #   line_items << item
  #  end
  #end
  
  def purchase(total)
    @price_in_cents = total
    response = process_purchase
    transactions.create!(:action => "purchase", :amount =>@price_in_cents, :response => response)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end
  # for express token chkout
  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.last_name = details.params["last_name"]
    end
  end

  
  #def price_in_cents
  #  (cart.total_price*100).round
  #end

 # def total_price 
 #   line_items.to_a.sum { |item| item.total_price}
 # end

  def total_items
	 line_items.sum(:quantity)
	end 

  private
  # for purchase options 
  def process_purchase
    if express_token.blank? 
      STANDARD_GATEWAY.purchase(@price_in_cents, credit_card, standard_purchase_options)
    else
      EXPRESS_GATEWAY.purchase(@price_in_cents , express_purchase_options)
    end 
  end
  
  def standard_purchase_options
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
  def express_purchase_options
   {
    :ip => ip_address,
    :token => express_token,
    :payer_id => express_payer_id
   }
  end
  def validate_card
     if express_token.blank? && !credit_card.valid?
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
