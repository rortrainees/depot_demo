class AddNameFieldToOrders < ActiveRecord::Migration
  def self.up
  	add_column :orders , :card_type ,:string
  	add_column :orders , :first_name , :string
  	add_column :orders , :last_name , :date
  	remove_column :orders , :name
  	remove_column :orders , :pay_type
  end

  def self.down
  	remove_column :orders , :card_type
  	remove_column :orders , :first_name 
  	remove_column :orders , :last_name 
  end
end
