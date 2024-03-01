# frozen_string_literal: true

module Api
  module V1
    class BuyerController < ApplicationController
      # GET api/v1/list_seller_suggestions
      def list_seller_suggestions
        GetSellerSuggestions.call(accepted_params)
      end

      private

      def accepted_params
        params.require(:purchase).permit(:buyer, :produce, :status, :seller)
      end
    end
  end
end
