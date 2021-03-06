# frozen_string_literal: true

module Category::Operation
  class Create < ApplicationOperation
    step :create_category
    step :valid_category

    def create_category(options, params:, **)
      options[:category] = Category.create(params)
    end

    def valid_category(options, category:, **)
      result = validation_model(category)
      return true unless result[:error]

      options[:error] = result
      false
    end
  end
end
