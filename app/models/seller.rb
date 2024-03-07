# frozen_string_literal: true

class Seller < ApplicationRecord
  has_many :purchases, dependent: :nullify

  validates_presence_of :name
end
