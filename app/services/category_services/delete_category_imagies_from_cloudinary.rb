# frozen_string_literal: true

module CategoryServices
  class DeleteCategoryImagiesFromCloudinary
    attr_reader :category

    def initialize(category)
      @category = category
    end

    def call
      @category.questions.each do |question|
        CloudinaryServices::Delete.new(question.id).call
      end
    end
  end
end
