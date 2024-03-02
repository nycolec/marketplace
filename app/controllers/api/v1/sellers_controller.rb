# frozen_string_literal: true

module Api
  module V1
    class SellersController < ApplicationController
      # GET api/v1/sellers/:id/list_suggestions
      def list_suggestions
        GetSuggestionsForSeller.call(seller_id: params[:id])

        return result.matches if result.success?

        result.error
      end
    end
  end
end
