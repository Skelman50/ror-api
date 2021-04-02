# frozen_string_literal: true

class CategoryConcept
  class DestroyAll < ApplicationOperation
    step :destroy_all

    def destroy_all(_options, **)
      Category.destroy_all
    end
  end
end
