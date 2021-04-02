# frozen_string_literal: true

class CategoryConcept
  class Show < ApplicationOperation
    step :find_category
    step :find_category_questions
    step :find_category_questions_size
    step :prepare_json

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

    def find_category_questions(options, category:, **)
      questions = category.questions
      items = CategoryQuestionsPresenters::Collection.new(questions).call
      options[:items] = items[:response]
    end

    def find_category_questions_size(options, category:, **)
      options[:count] = category.questions.size
    end

    def prepare_json(options, category:, items:, count:, **)
      options[:response] = {
        items: items,
        count: count,
        category: category
      }
    end
  end
end
