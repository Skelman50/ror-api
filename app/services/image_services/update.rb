# frozen_string_literal: true

module ImageServices
  class Update
    attr_reader :question, :params, :image

    def initialize(question, params, image)
      @question = question
      @params = params
      @image = image
    end

    def call
      image_data = @params[:image]
      return true if image_data.is_a? String

      uploaded_image = CloudinaryServices::Upload.new(@params, @question).call
      file = File.open(params[:image].tempfile.path)
      file_data = file.read
      @image.update(url: uploaded_image['url'], image: file_data)
    end
  end
end