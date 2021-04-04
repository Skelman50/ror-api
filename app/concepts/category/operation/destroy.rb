# frozen_string_literal: true

class CategoryConcept
  class Destroy < ApplicationOperation
    step :find_category
    step :delete_category_imagies_from_cloudinary
    step :destroy

    def find_category(options, id:, **)
      category = Category.find_by(id: id)
      if category
        options[:category] = category
        true
      else
        options[:error] = { message: 'Category not found' }
        false
      end
    end

    def delete_category_imagies_from_cloudinary(_options, category:, **)
      CategoryServices::DeleteCategoryImagiesFromCloudinary.new(category).call
    end

    def destroy(_options, category:, **)
      category.destroy
    end
  end
end
