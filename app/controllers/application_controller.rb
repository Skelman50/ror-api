# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def error_handler(result)
    render json: result[:error] || default_error, status: result[:status] || default_error[:status]
  end

  private

  def default_error
    { message: 'Something went wrong', status: 500 }
  end
end
