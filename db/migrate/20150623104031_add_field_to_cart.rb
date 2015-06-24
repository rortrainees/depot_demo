class AddFieldToCart < ActiveRecord::Migration
  def self.up
   add_column :orders , :authorization , :integer
   remove_column :orders , :authorization_code , :string
  end

  def self.down
  end
end
