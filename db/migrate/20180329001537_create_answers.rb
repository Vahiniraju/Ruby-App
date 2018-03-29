class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :title
      t.reference :question, foreign_key: true
      t.boolean :is_correct

      t.timestamps
    end
  end
end
