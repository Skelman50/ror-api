# frozen_string_literal: true

module User::Operation
  class AutoLogin < ApplicationOperation
    step :update_token

    def update_token(options, params:, **)
      user = params[:user]
      token = encode_token(user_id: user.id)
      options[:response] = token
    end
  end
end
