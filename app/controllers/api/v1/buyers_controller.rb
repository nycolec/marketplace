# frozen_string_literal: true

module Api
  module V1
    class BuyersController < ApplicationController
      # GET /api/v1/buyers/:buyer_id/suggestions
      def suggestions
        result = ::GetSuggestionsForBuyer.call(buyer_id: params[:buyer_id])

        if result.success?
          render json: result.matches, status: :ok
        else
          render json: { error: result.error }, status: result.status
        end
      end
    end
  end
end
