class AddFieldToOrders < ActiveRecord::Migration
  def self.up
  	add_column :orders , :cart_id ,:integer
  	add_column :orders , :ip_address , :string
  	add_column :orders , :card_expires_on , :date
  end

  def self.down
  	remove_column :orders , :cart_id
  	remove_column :orders , :ip_address
  	remove_column :orders , :card_expires_on 
  end
end
