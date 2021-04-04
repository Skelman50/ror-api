# frozen_string_literal: true

class CategoryConcept
  class GetAll < ApplicationOperation
    step :get_categories

    def get_categories(options, **)
      categories = Category.order(created_at: :desc).all
      options[:categories] = CategoryPresenters::Collection.new(categories).call
    end
  end
end