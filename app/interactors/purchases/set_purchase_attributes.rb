# frozen_string_literal: true

module Purchases
  class SetPurchaseAttributes
    include Interactor

    def call
      p '4'
      context.purchase.assign_attributes(
        buyer: context.buyer,
        seller: context.seller,
        produce: context.produce,
        status: context.params[:status]
      )

      context.purchase[:date_purchased] = Time.now unless context.purchase.cancelled?
    end
  end
end
