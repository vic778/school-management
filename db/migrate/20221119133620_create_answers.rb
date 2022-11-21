class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers do |t|
      t.string :name
      t.boolean :answer, default: false
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
