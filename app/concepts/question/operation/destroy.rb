# frozen_string_literal: true

class QuestionConcept
  class Destroy < ApplicationOperation
    step :find_question
    step :delete_image_from__cloudinary
    step :destroy

    def find_question(options, id:, **)
      question = Question.find(id)
      if question
        options[:question] = question
        true
      else
        options[:error] = { message: 'Question not found' }
        false
      end
    end

    def delete_image_from__cloudinary(_options, question:, **)
      Cloudinary::Uploader.destroy("#{ENV['CLOUDINARY_FOLDER']}/#{question.id}")
    end

    def destroy(_options, question:, **)
      question.destroy
    end
  end
end
