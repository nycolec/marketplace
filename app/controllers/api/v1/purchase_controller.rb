# frozen_string_literal: true

module Api
  module V1
    class PurchaseController < ApplicationController
      # POST api/v1/purchase
      def create
        CreatePurchase.call(accepted_params)

        # seller, buyer, produce, status
      end

      private

      def accepted_params
        params.require(:purchase).permit(:buyer, :produce, :status, :seller)
      end
    end
  end
end
