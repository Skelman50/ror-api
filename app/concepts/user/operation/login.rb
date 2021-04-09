# frozen_string_literal: true

module User::Operation
  class Login < ApplicationOperation
    step :find_user
    step :authenticate_user

    def find_user(options, params:, **)
      user = User.find_by(name: params[:name])

      if !user
        options[:error] = login_error
        false
      else
        options[:user] = user
      end
    end

    def authenticate_user(options, params:, user:, **)
      auth_user = user.authenticate(params[:password])
      if !auth_user
        options[:error] = login_error
        false
      else
        token = encode_token(user_id: auth_user.id)
        options[:response] = token
      end
    end

    private

    def login_error
      { message: 'Пароль або логін не співападають', status: 401 }
    end
  end
end
