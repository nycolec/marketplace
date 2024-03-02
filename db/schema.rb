# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_229_185_254) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'buyers', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'produces', force: :cascade do |t|
    t.string 'produce_type'
    t.text 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'purchases', force: :cascade do |t|
    t.bigint 'buyer_id'
    t.bigint 'seller_id'
    t.bigint 'produce_id'
    t.datetime 'date_purchased', precision: nil
    t.integer 'status', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['buyer_id'], name: 'index_purchases_on_buyer_id'
    t.index ['produce_id'], name: 'index_purchases_on_produce_id'
    t.index ['seller_id'], name: 'index_purchases_on_seller_id'
  end

  create_table 'sellers', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'purchases', 'buyers'
  add_foreign_key 'purchases', 'produces'
  add_foreign_key 'purchases', 'sellers'
end
