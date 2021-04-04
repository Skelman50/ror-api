# frozen_string_literal: true

module CategoryServices
  class DestroyAll
    def call
      categories = Category.all
      categories.each do |category|
        questions = category.questions
        CloudinaryServices::DeleteAll.new(questions).call
      end
      categories.destroy_all
    end
  end
end
