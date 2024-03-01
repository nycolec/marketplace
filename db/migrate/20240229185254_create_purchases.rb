class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :buyer, foreign_key: true
      t.references :seller, foreign_key: true
      t.references :produce, foreign_key: true
      t.timestamp :date_purchased
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
