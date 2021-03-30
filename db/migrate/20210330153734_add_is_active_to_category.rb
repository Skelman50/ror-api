# frozen_string_literal: true

class AddIsActiveToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :is_active, :boolean, default: false
  end
end
