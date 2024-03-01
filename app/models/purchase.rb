# frozen_string_literal: true

class Purchase < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :produce

  enum status: { completed: 0, cancelled: 1 }
end
