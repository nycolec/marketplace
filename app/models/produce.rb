# frozen_string_literal: true

class Produce < ApplicationRecord
  has_many :purchases, dependent: :nullify
end
