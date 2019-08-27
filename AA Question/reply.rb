require_relative "questions.rb"
require "byebug"

class Reply
 attr_accessor :id, :body, :user_id, :question_id, :parent_reply_id, :child_reply_id

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL
    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def self.find_by_question_id(question_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = ?
    SQL
    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    # @child_reply_id = options['child_reply_id']
  end

  def author
    author = User.find_by_id(self.user_id)
    # author.fname + " " + author.lname
  end

  def question
    question = Question.find_by_id(self.question_id)
    # question.title + 2.times {puts} + question.body
  end

  def parent_reply
    parent = Reply.find_by_id(self.parent_reply_id)
    # parent.body
  end

  def child_replies
    raise "#{self} not in database" unless @id
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL
    return nil unless reply.length > 0
    children = []
    reply.each { |child| children << Reply.new(child) }
    children    
  end
end