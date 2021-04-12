# frozen_string_literal: true

module Question::Operation
  class Update < ApplicationOperation
    step :find_question
    step :find_question_image
    step :parse_answers
    step :true_answer?
    step :is_image_exist?
    step :validate_image_size
    step :start_transaction

    def find_question(options, params:, **)
      question = Question.find(params[:id])
      unless question
        options[:error] = { message: 'Запитання не знайдено', status: 400 }
        return false
      end
      options[:question] = question
    end

    def find_question_image(options, question:, **)
      options[:image] = question.image
    end

    def parse_answers(options, params:, **)
      options[:answers] = JSON.parse(params[:answers])
    end

    def true_answer?(options, answers:, **)
      is_true = answers.find { |a| a['isTrue'] }
      return true if is_true

      options[:error] = { message: 'Необхідна хоч одна вірна відповідь', status: 400 }
      false
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

    def start_transaction(options, params:, answers:, question:, image:, **)
      ActiveRecord::Base.transaction do
        question.update!(title: params[:title], category_id: params[:category_id])
        AnswerServices::UpdateAnswers.new(answers).call
        ImageServices::Update.new(question, params, image).call
      end
    rescue StandardError => e
      options[:error] = generate_transaction_error(e)
      false
    end
  end
end
