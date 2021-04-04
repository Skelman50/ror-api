# frozen_string_literal: true

module CloudinaryServices
  class Upload
    attr_reader :params, :question

    def initialize(params, question)
      @params = params
      @question = question
    end

    def call
      Cloudinary::Uploader.upload(@params[:image].tempfile.path,
                                  folder: ENV['CLOUDINARY_FOLDER'],
                                  public_id: @question.id, overwrite: true)
    end
  end
end
