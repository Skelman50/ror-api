# frozen_string_literal: true

class Category
  class Show < ApplicationOperation
    step :find_category
    step :find_category_questions
    step :find_category_questions_size
    step :prepare_json

    def find_category(options, params:, **)
      category = Category.find_by(id: params[:id])
      if category
        options[:category] = category
        true
      else
        options[:error] = { message: 'Category not found' }
        false
      end
    end

    def find_category_questions(options, category:, params:, **)
      questions = category.questions.order(created_at: :desc).limit(params[:limit]).offset(params[:offset])
      items = QuestionsPresenters::Collection.new(questions).call
      options[:items] = items[:response]
    end

    def find_category_questions_size(options, category:, **)
      options[:count] = category.questions.count
    end

    def prepare_json(options, category:, items:, count:, **)
      options[:response] = {
        # items: items,
        # count: count,
        category: category
      }
    end
  end
end
