# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token

  def error_handler(result)
    render json: result[:error] || default_error, status: result[:error][:status] || default_error[:status]
  end

  private

  def default_error
    { message: 'Something went wrong', status: 500 }
  end
end
