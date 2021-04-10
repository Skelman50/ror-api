# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]
  def login
    result = User::Operation::Login.call(params: params)
    generate_response(result)
  end

  def auto_login
    result = User::Operation::AutoLogin.call(params: { user: @user })
    generate_response(result)
  end
end
