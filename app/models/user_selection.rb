class UserSelection < ApplicationRecord
  validates_uniqueness_of :question_id, scope: :user_id
  belongs_to :question
  belongs_to :user
  belongs_to :answer
  validates :question_id,:answer_id,:user_id , presence: true
  validate :question_user_rel
  validate :question_answer_rel
  before_save :assign_correct_answer

  def assign_correct_answer
    self.correct_answer = self.question.correct_answer == self.answer
  end

  def question_user_rel
    errors.add(:base,"You cannot answer your own question") if self.question.user_id == self.user_id
  end

  def question_answer_rel
    errors.add(:base,"Answer needs to belong to the appropriate question") unless self.question.answers.collect(&:id).include?(self.answer_id)
  end
end
