require_relative "questions.rb"

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    question_like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL
    return nil unless question_like.length > 0
    QuestionLike.new(question_like.first)
  end

  def initialize(options)
    # @liked = options['liked']
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
end