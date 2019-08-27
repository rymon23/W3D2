PRAGMA FOREIGN_KEYS = ON;

DROP TABLE question_likes;
DROP TABLE question_follows;
DROP TABLE replies;
DROP TABLE questions;
DROP TABLE users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL   
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (question_id) REFERENCES questions (id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  -- child_reply_id INTEGER,

  FOREIGN KEY (question_id) REFERENCES questions (id)
  FOREIGN KEY (user_id) REFERENCES users (id)
  FOREIGN KEY (parent_reply_id) REFERENCES replies (id)
  -- FOREIGN KEY (child_reply_id) REFERENCES replies (id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users (id)
  FOREIGN KEY (question_id) REFERENCES questions (id)
);

INSERT INTO users ("fname", "lname") VALUES ("Roy", "Toomey");
INSERT INTO users ("fname", "lname") VALUES ("Bob", "North");
INSERT INTO users ("fname", "lname") VALUES ("Sonya", "Tillerson");
INSERT INTO users ("fname", "lname") VALUES ("Bill", "Billerson");
INSERT INTO questions ("title", "body", "user_id") VALUES ("How do I open this new package of rice crispy treats?", "hfdshjkdfsjkhdfsjbhdfsbhjdsfhjkdfsadsfsdfsdfsdfsdfsdf", 3);
INSERT INTO questions ("title", "body", "user_id") VALUES ("Q2", "2222222", 2);
INSERT INTO questions ("title", "body", "user_id") VALUES ("Q1", "1", 1);
INSERT INTO question_likes ("user_id", "question_id") VALUES (2, 1);
INSERT INTO replies ("body", "user_id", "question_id", "parent_reply_id") VALUES ("parent reply", 1, 1, NULL);
INSERT INTO replies ("body", "user_id", "question_id", "parent_reply_id") VALUES ("child reply", 2, 1, 1);
INSERT INTO question_follows ("user_id", "question_id") VALUES (1, 1);

-- cat import_db.sql | sqlite3 questions.db
-- pry
-- load 'questions.rb'
-- User.all
  -- Question.all
  -- Question.followed_questions_for_user_id