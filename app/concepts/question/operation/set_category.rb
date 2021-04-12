# frozen_string_literal: true

module Question::Operation
  class SetCategory < ApplicationOperation
    step :find_category
    step :find_question
    step :set_category

    def find_category(options, params:, **)
      category = Category.find(params[:categoryId])
      unless category
        options[:error] = { message: 'Category not found', status: 404 }
        return false
      end
      options[:category] = category
    end

    def find_question(options, params:, **)
      question = Question.find(params[:question_id])
      unless question
        options[:error] = { message: 'Question not found', status: 404 }
        return false
      end
      options[:question] = question
    end

    def set_category(options, category:, question:, **)
      question.update(category_id: category.id)
      return true if question.valid?

      options[:error] = { message: category.errors[:title][0] }
      false
    end
  end
end
