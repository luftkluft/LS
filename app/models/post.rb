class Post < ApplicationRecord
  validates :title, :summary, :body, presence: true
  validates :level, numericality: true, presence: true
end
