# frozen_string_literal: true

module Api
  module V1
    class SellersController < ApplicationController
      # GET api/v1/sellers/:id/list_suggestions
      def suggestions
        result = ::GetSuggestionsForSeller.call(seller_id: params[:seller_id])

        if result.success?
          render json: result.matches, status: :ok
        else
          render json: { error: result.error }, status: result.status
        end
      end
    end
  end
end
