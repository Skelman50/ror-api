# frozen_string_literal: true

class Question
  module Operation
    class Create < ApplicationOperation
      step :parse_answers
      step :true_answer?
      step :is_image_exist?
      step :validate_image_size
      step :start_transition

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

      def start_transition(options, params:, answers:, **)
        ActiveRecord::Base.transaction do
          question = create_question(params)
          create_answers(answers, question)
          image = upload_image(question, params)
          create_image(question, params, image)
        end
      rescue StandardError => e
        options[:error] = generate_error(e)
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

      def create_image(question, params, image)
        Image.create!(question_id: question.id, image: params[:image], url: image['url'])
      end

      def generate_error(e)
        { message: e }
      end

      def upload_image(question, params)
        CloudinaryServices::Upload.new(params, question).call
      end
    end
  end
end
