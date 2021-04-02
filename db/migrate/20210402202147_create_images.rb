# frozen_string_literal: true

class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images, id: :uuid do |t|
      t.binary :image
      t.string :url
      t.references :question, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
