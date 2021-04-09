# frozen_string_literal: true

module Question::Operation
  class Update < ApplicationOperation
    step :find_question
    step :find_question_image
    step :parse_answers
    step :true_answer?
    step :is_image_exist?
    step :validate_image_size
    step :start_transition

    def find_question(options, params:, **)
      question = Question.find(params[:id])
      if question
        options[:question] = question
      else
        options[:error] = { message: 'Запитання не знайдено', status: 400 }
        false
      end
    end

    def find_question_image(options, question:, **)
      options[:image] = question.image
    end

    def parse_answers(options, params:, **)
      options[:answers] = JSON.parse(params[:answers])
    end

    def true_answer?(options, answers:, **)
      is_true = answers.find { |a| a['isTrue'] }
      if !is_true
        options[:error] = { message: 'Необхідна хоч одна вірна відповідь', status: 400 }
        false
      else
        true
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

    def start_transition(options, params:, answers:, question:, image:, **)
      ActiveRecord::Base.transaction do
        update_question(params, question)
        update_answers(answers)
        upload_image(question, params, image)
      end
    rescue StandardError => e
      options[:error] = generate_transaction_error(e)
      false
    end

    private

    def update_question(params, question)
      question.update!(title: params[:title], category_id: params[:category_id])
    end

    def update_answers(answers)
      answers.each do |answer|
        a = Answer.find(answer['id'])
        a.update!({ isTrue: answer['isTrue'],
                    displayMessage: answer['displayMessage'],
                    title: answer['title'],
                    description: answer['description'] })
      end
    end

    def upload_image(question, params, image)
      image_data = params[:image]
      if !image_data.is_a? String
        uploaded_image = CloudinaryServices::Upload.new(params, question).call
        image.update(url: uploaded_image['url'], image: image_data)
      else
        true
      end
    end
  end
end
