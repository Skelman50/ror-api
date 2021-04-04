# frozen_string_literal: true

class CategoryConcept
  class DestroyAll < ApplicationOperation
    step :get_all_categories
    step :destroy_all

    def get_all_categories(options, **)
      options[:categories] = Category.all
    end

    def destroy_all(_options, categories:, **)
      CategoryServices::DestroyAll.new(categories).call
    end
  end
end
