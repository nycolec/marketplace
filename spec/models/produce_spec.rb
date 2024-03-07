# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Produce, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:produce_type) }
  end
end
