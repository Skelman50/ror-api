# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }

  belongs_to :category
  has_one :image, dependent: :destroy
end
