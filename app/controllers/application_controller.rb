# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authorized

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      # header: { 'Authorization': 'Bearer <token>' }
      begin
        JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def logged_in_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!logged_in_user
  end

  def authorized
    binding.pry
    unless logged_in?
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end

  def error_handler(result)
    render json: result[:error] || default_error, status: result[:error][:status] || default_error[:status]
  end

  private

  def default_error
    { message: 'Something went wrong', status: 500 }
  end
end
