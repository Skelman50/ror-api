# frozen_string_literal: true

class CategoryConcept
  class DestroyAll < ApplicationOperation
    step :get_all_categories
    step :delete_imagies_from_cloudinary
    step :destroy_all

    def get_all_categories(options, **)
      options[:categories] = Category.all
    end

    def delete_imagies_from_cloudinary(_options, categories:, **)
      CategoryServices::DeleteAllImagiesFromCloudinary.new(categories).call
    end

    def destroy_all(_options, categories:, **)
      categories.destroy_all
    end
  end
end
