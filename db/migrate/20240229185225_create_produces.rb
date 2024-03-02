# frozen_string_literal: true

class CreateProduces < ActiveRecord::Migration[7.1]
  def change
    create_table :produces do |t|
      t.string :produce_type
      t.text :description

      t.timestamps
    end
  end
end
