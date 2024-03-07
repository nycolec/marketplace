# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActionController::ParameterMissing, :with => :bad_request

  def bad_request(exception)
    render json: { error: exception }, status: :bad_request
  end
end
