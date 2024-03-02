# frozen_string_literal: true

class PurchaseSerializer < ActiveModel::Serializer
  attributes :id, :date_purchased, :status

  attribute :produce_type do
    object.produce.produce_type
  end
end
