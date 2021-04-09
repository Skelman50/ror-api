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
        false
      else
        options[:answers] = result[:answers]
      end
    end

    def is_image_exist?(options, params:, **)
      if params[:image] == 'null'
        options[:error] = { message: 'Треба завантажити картинку', status: 400 }
        false
      else
        true
      end
    end

    def validate_image_size(options, params:, **)
      size = params[:image].size
      if size > 150_000
        options[:error] = { message: 'Картинка занадто велика', status: 400 }
        false
      else
        true
      end
    end

    def start_transition(options, params:, answers:, **)
      ActiveRecord::Base.transaction do
        question = create_question(params)
        create_answers(answers, question)
        image = CloudinaryServices::Upload.new(params, question).call
        Image.create!(question_id: question.id, image: params[:image], url: image['url'])
      end
    rescue StandardError => e
      options[:error] = generate_transaction_error(e)
      false
    end

    private

    def create_question(params)
      Question.create!(title: params[:title], category_id: params[:category_id])
    end

    def create_answers(answers, question)
      answers.each do |answer|
        Answer.create!({ isTrue: answer['isTrue'],
                         displayMessage: answer['displayMessage'],
                         title: answer['title'],
                         description: answer['description'],
                         question_id: question.id })
      end
    end
  end
end
