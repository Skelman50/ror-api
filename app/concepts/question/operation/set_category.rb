# frozen_string_literal: true

class QuestionConcept
  class SetCategory < ApplicationOperation
    step :find_category
    step :find_question
    step :set_category

    def find_category(options, params:, **)
      category = Category.find(params[:categoryId])
      if !category
        options[:error] = { message: 'Category not found', status: 404 }
        false
      else
        options[:category] = category
      end
    end

    def find_question(options, params:, **)
      question = Question.find(params[:question_id])
      if !question
        options[:error] = { message: 'Question not found', status: 404 }
        false
      else
        options[:question] = question
      end
    end

    def set_category(options, category:, question:, **)
      question.update(category_id: category.id)
      if question.valid?
        true
      else
        options[:error] = { message: category.errors[:title][0] }
        false
      end
    end
  end
end
