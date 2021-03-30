# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }

  has_many :questions, dependent: :destroy
end
