require_relative "questions.rb"

class Question
  attr_accessor :title, :body, :user_id, :id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL
    return nil unless question.length > 0
    Question.new(question.first)
  end

  def self.find_by_user_id(user_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL
    return nil unless question.length > 0
    Question.new(question.first)
  end

  def initialize(options)
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    author = User.find_by_id(self.user_id)
    author.fname + " " + author.lname
  end

  def replies
    reply = Reply.find_by_question_id(self.user_id)
    reply.body
  end
end
