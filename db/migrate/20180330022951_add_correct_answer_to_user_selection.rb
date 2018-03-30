class AddCorrectAnswerToUserSelection < ActiveRecord::Migration[5.1]
  def change
    add_column :user_selections, :correct_answer, :boolean, default: false
  end
end
