# frozen_string_literal: true

class Category < ApplicationRecord
  validates :title, length: { minimum: 3, message: 'Недостатньо символів (необхідно мінімум 3)' }
  validates :title, uniqueness: { message: "Ім'я категорії має бути унікальним" }

  has_many :questions, dependent: :destroy
end
