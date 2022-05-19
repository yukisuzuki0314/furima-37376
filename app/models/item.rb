class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :image, presence: true
  validates :item_name, presence: true, length: { maximum: 40}
  validates :item_info, presence: true, length: { maximum: 1000}
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :item_status_id , numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_fee_status_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id , numericality: { other_than: 1 , message: "can't be blank"}
  validates :scheduled_delivery_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,message: "is out of setting range" }
  validates :price, numericality: { only_integer: true, message: "is invalid. Input half-width characters"}
end