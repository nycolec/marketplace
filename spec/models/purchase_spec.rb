# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe 'associations' do
    it { should belong_to(:seller) }
    it { should belong_to(:produce) }
    it { should belong_to(:buyer) }
  end
end
