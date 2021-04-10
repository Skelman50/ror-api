# frozen_string_literal: true

module Category::Operation
  class GetAll < ApplicationOperation
    step :get_categories

    def get_categories(options, **)
      options[:response] = Category.joins(:questions)
                                   .select('"categories".*, COUNT(questions.id) as questions_count')
                                   .order(created_at: :desc)
                                   .group('categories.id')
    end
  end
end
