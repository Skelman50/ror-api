# frozen_string_literal: true

module Question::Operation
  class Create < ApplicationOperation
    step :ensure_true_answer
    step :is_image_exist?
    step :validate_image_size
    step :start_transition

    def ensure_true_answer(options, params:, **)
      answers = params[:answers]
      result = QuestionServices::EnsureTrueAnswer.new(answers).call
      if result[:error]
        options[:error] = result[:error]
        return false
      end
      options[:answers] = result[:answers]
    end

    def is_image_exist?(options, params:, **)
      return true if params[:image] != 'null'

      options[:error] = { message: 'Треба завантажити картинку', status: 400 }
      false
    end

    def validate_image_size(options, params:, **)
      size = params[:image].size
      return true if size <= 150_000

      options[:error] = { message: 'Картинка занадто велика', status: 400 }
      false
    end

    def start_transition(options, params:, answers:, **)
      ActiveRecord::Base.transaction do
        question = Question.create!(title: params[:title], category_id: params[:category_id])
        AnswerServices::CreateAnswers.new(answers, question).call
        ImageServices::Create.new(question, params).call
      end
    rescue StandardError => e
      options[:error] = generate_transaction_error(e)
      false
    end
  end
end
