# frozen_string_literal: true

module Api
  module V1
    class PurchasesController < ApplicationController
      # POST /api/v1/purchases
      def create
        result = ::CreatePurchase.call(params: purchase_params)

        if result.success?
          render json: result.purchase, status: :created
        else
          render json: { error: result.error }, status: result.status
        end
      end

      private

      def purchase_params
        params.require(:purchase).permit(:buyer, :produce, :status, :seller)
      end
    end
  end
end
