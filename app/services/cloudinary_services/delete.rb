# frozen_string_literal: true

module CloudinaryServices
  class Delete
    attr_reader :public_id

    def initialize(public_id)
      @public_id = public_id
    end

    def call
      Cloudinary::Uploader.destroy("#{ENV['CLOUDINARY_FOLDER']}/#{@public_id}")
    end
  end
end
