# frozen_string_literal: true

class QuestionConcept
  class Create < ApplicationOperation
    step :start_transition

    def start_transition(options, params:, **)
      ActiveRecord::Base.transaction do
        question = create_question(params)
        create_answers(params, question)
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

    def create_answers(params, question)
      answers = JSON.parse(params[:answers])
      answers.each do |answer|
        Answer.create!(isTrue: answer[:isTrue], displayMessage: answer[:displayMessage], title: answer[:title], description: answer[:description], question_id: question.id)
      end
    end

    def create_image(question, params, image)
      Image.create!(question_id: question.id, image: params[:image], url: image['url'])
    end

    def generate_error(e)
      { message: e.message.split(': ')[1].split(' ').drop(1).join(' '), status: 400 }
    end

    def upload_image(question, params)
      Cloudinary::Uploader.upload(params[:image].tempfile.path,
                                  folder: ENV['CLOUDINARY_FOLDER'], public_id: question.id, overwrite: true)
    end
  end
end
