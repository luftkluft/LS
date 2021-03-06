class Post < ApplicationRecord
  validates :title, :summary, :body, presence: true
  validates :level, numericality: true, presence: true
  mount_uploader :image, ImageUploader
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  belongs_to :category

  def all_tags
    tags.map(&:name).join(', ')
  end

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def self.user_level_posts(current_user)
    where('level <= ?', current_user.level).order(created_at: :desc)
  end
end
