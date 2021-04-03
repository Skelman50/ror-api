# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers, id: :uuid do |t|
      t.string :title
      t.string :displayMessage
      t.text :description
      t.boolean :isTrue

      t.references :question, null: false, foreign_key: { on_delete: :cascade }, type: :uuid

      t.timestamps
    end
  end
end
