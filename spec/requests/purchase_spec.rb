# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Purchases', type: :request do
  describe 'POST /api/v1/purchases' do
    let(:food) { create(:produce, produce_type: 'Yam') }
    let(:seller) { create(:seller) }
    let(:buyer) { create(:buyer) }

    context 'when params are invalid' do
      context 'when produce type does not exist' do
        let(:invalid_params) do
          {
            purchase: {
              seller: seller.id,
              buyer: buyer.id,
              produce: 'Cereal'
            }
          }
        end

        it 'returns 404' do
          post '/api/v1/purchases', params: invalid_params
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when params are valid' do
      let(:valid_params) do
        {
          purchase: {
            #  use factory bot to scale
            seller: seller.id,
            buyer: buyer.id,
            produce: food.produce_type,
            status: :completed
          }
        }
      end

      it 'returns http success' do
        post '/api/v1/purchases', params: valid_params
        expect(response).to have_http_status(:created)
      end
    end
  end
end
