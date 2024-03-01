# frozen_string_literal: true

class Seller < ApplicationRecord
  has_many :purchases, dependent: :nullify
end
