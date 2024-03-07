# frozen_string_literal: true

module Produces
  class FindProduce
    include Interactor

    def call
      context.produce = Produce.find_by(produce_type: context.params[:produce])

      context.fail!(error: 'Produce type not found', status: 404) unless context.produce.present?
    end
  end
end
