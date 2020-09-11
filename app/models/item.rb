class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :burden
  belongs_to_active_hash :duration
  belongs_to_active_hash :prefecture

  validates :name, :price, :content, :category, :status, :burden, :duration, :prefecture, :image, presence: true
  validates :category_id, :status_id, :burden_id, :duration_id, :prefecture_id, numericality: { other_than: 1 } 
  validates :price, numericality: { only_interger: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
end
