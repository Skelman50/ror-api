# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  def login
    result = User::Operation::Login.call(params: params)
    if result.success?
      render json: { response: result[:response] }
    else
      error_handler(result)
    end
  end

  def auto_login
    result = User::Operation::AutoLogin.call(params: { user: @user })
    if result.success?
      render json: { response: result[:response] }
    else
      error_handler(result)
    end
  end
end
