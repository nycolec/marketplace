# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Buyers', type: :request do
  describe 'GET /api/v1/buyers/:id/suggestions' do
    let(:seller) { Seller.create(name: Faker::Name.name) }
    let(:seller2) { Seller.create(name: Faker::Name.name) }
    let(:seller3) { Seller.create(name: Faker::Name.name) }
    let(:buyer) { Buyer.create(name: Faker::Name.name) }
    let(:other_buyer) { Buyer.create(name: Faker::Name.name) }
    let(:fruit) { Produce.create(produce_type: 'Apple') }
    let(:fruit2) { Produce.create(produce_type: 'Tomato') }
    let(:fruit3) { Produce.create(produce_type: 'Plum') }
    let(:purchase) { Purchase.create(buyer:, seller:, produce: fruit) }
    let(:buyer_params) do
      { buyer_id: buyer.id }
    end

    context 'when buyers have minimal purchases' do
      it 'returns http success' do
        get '/api/v1/buyers/:buyer_id/suggestions', params: buyer_params
        expect(response).to have_http_status(:success)
      end
    end

    context 'when buyers have made multiple purchases' do
      context 'when purchases are not within 14 days' do
        it 'returns http success' do
          get '/api/v1/buyers/:buyer_id/suggestions', params: buyer_params
          expect(response).to have_http_status(:success)
        end
      end

      context 'when completed purchases are within 14 days' do
        it 'returns http success' do
          5.times do
            Purchase.create!(
              date_purchased: Faker::Time.between(from: 15.days.ago, to: Time.now),
              produce: [fruit, fruit2, fruit3].sample,
              buyer_id: buyer.id,
              seller_id: [seller.id, seller2.id, seller3.id].sample,
              status: :completed
            )

            purchases = ActiveRecord::Base.connection.execute(
              "SELECT purchases.produce_id, purchases.date_purchased, sellers.name, purchases.seller_id, purchases.id
                FROM purchases
                INNER JOIN sellers ON purchases.seller_id = sellers.id
                WHERE purchases.buyer_id = #{buyer.id} AND purchases.status <> 1
                ORDER BY purchases.produce_id DESC, purchases.date_purchased DESC"
            )

            expect(purchases).to eq('Offline')
          end

          get '/api/v1/buyers/:buyer_id/suggestions', params: buyer_params
          expect(response).to have_http_status(:success)
        end
      end

      context 'when cancelled purchases are not within 14 days' do
        it 'returns http success' do
          get '/api/v1/buyers/:buyer_id/suggestions', params: buyer_params
          expect(response).to have_http_status(:success)
        end
      end

      context 'when cancelled purchases are within 14 days' do
        it 'returns http success' do
          get '/api/v1/buyers/:buyer_id/suggestions', params: buyer_params
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
