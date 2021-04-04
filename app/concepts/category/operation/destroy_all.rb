# frozen_string_literal: true

class CategoryConcept
  class DestroyAll < ApplicationOperation
    step :destroy_all

    def destroy_all(_options, **)
      CategoryServices::DestroyAll.new.call
    end
  end
end
