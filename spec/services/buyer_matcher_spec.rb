# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BuyerMatcher do
  describe '.get_purchase_for_buyer' do
    context 'when buyer is provided' do
      let(:buyer) { Buyer.create!(name: Faker::Name.name) }
      it 'returns buyer data' do
        purchases = ActiveRecord::Base.connection.execute(
          "SELECT purchases.produce_id, purchases.date_purchased, sellers.name, purchases.seller_id, purchases.id
          FROM purchases
          INNER JOIN sellers ON purchases.seller_id = sellers.id
          WHERE purchases.buyer_id = #{buyer.id} AND purchases.status <> 1
          ORDER BY purchases.produce_id DESC, purchases.date_purchased DESC"
        )

        expect(BuyerMatcher.new(buyer:).find_matches).to eq(purchases.to_a)
      end
    end
  end
end
