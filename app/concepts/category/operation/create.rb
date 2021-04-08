# frozen_string_literal: true

module Category::Operation
  class Create < ApplicationOperation
    step :create_category
    step :valid_category

    def create_category(options, params:, **)
      options[:category] = Category.create(params)
    end

    def valid_category(options, category:, **)
      if category.valid?
        true
      else
        options[:error] = { message: category.errors[:title][0], status: 400 }
        false
      end
    end
  end
end
