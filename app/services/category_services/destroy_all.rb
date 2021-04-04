# frozen_string_literal: true

module CategoryServices
  class DestroyAll
    attr_reader :categories

    def initialize(categories)
      @categories = categories
    end

    def call
      @categories.each do |category|
        questions = category.questions
        CloudinaryServices::DeleteAll.new(questions).call
      end
      @categories.destroy_all
    end
  end
end
