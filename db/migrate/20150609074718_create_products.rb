class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.string :image_url
      t.string :description ,:precision => 8, :scale =>2
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
