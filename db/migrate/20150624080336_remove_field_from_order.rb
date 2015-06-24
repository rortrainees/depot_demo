class RemoveFieldFromOrder < ActiveRecord::Migration
  def self.up
  	remove_column :orders , :card_expires_on , :date
  end

  def self.down
    add_column :orders , :card_expires_on , :date
  end

end
