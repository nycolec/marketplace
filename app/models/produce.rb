# frozen_string_literal: true

class Produce < ApplicationRecord
  has_many :purchases, dependent: :nullify

  validates_presence_of :produce_type
end
