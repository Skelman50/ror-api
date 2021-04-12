# frozen_string_literal: true

module Question::Operation
  class Destroy < ApplicationOperation
    step :find_question
    step :delete_image_from__cloudinary
    step :destroy

    def find_question(options, id:, **)
      question = Question.find(id)
      unless question
        options[:error] = { message: 'Question not found' }
        return false
      end
      options[:question] = question
    end

    def delete_image_from__cloudinary(_options, question:, **)
      Cloudinary::Uploader.destroy("#{ENV['CLOUDINARY_FOLDER']}/#{question.id}")
    end

    def destroy(_options, question:, **)
      question.destroy
    end
  end
end
