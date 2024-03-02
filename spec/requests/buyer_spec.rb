# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Buyers', type: :request do
  describe 'GET /api/v1/buyers/:id/suggestions' do
    let(:seller) { Seller.create(name: Faker::Name.name) }
    let(:buyer) { Buyer.create(name: Faker::Name.name) }
    let(:fruit) { Produce.create(produce_type: 'Apple') }
    let(:buyer_params) do
      { buyer_id: buyer.id }
    end

    context 'when buyers have minimal purchases' do
      let(:purchase) { Purchase.create(buyer:, seller:, produce: fruit) }

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
