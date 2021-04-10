# frozen_string_literal: true

module Category::Operation
  class GetAll < ApplicationOperation
    step :get_categories

    def get_categories(options, **)
      categories = Category.order(created_at: :desc).all
      options[:response] = CategoryPresenters::Collection.new(categories).call
      # options[:response] = Category.left_outer_joins(:questions)
      #                              .select('"categories".*, COUNT(questions.id) as questions_count')
      #                              .order(created_at: :desc)
      #                              .group('categories.id')
    end
  end
end
