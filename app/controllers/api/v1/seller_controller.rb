# frozen_string_literal: true

module Api
  module V1
    class SellerController < ApplicationController
      # GET api/v1/list_buyer_suggestions
      def list_seller_suggestions
        GetBuyerSuggestions.call(accepted_params)
      end

      private

      def accepted_params
        params.require(:purchase).permit(:buyer, :produce, :status)
      end
    end
  end
end
