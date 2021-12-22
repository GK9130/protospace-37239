class Comment < ApplicationRecord
  belongs_to :prototype  # prototypesテーブルとのアソシエーション
  belongs_to :user  # usersテーブルとのアソシエーション

  validates :text, presence: true
end
