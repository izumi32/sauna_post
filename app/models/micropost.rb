class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :sauna, presence: true,
                    numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 1,
                                    only_integer: true}
  validates :evaluate, presence: true,
                       numericality: { greater_than_or_equal_to: 1,
                                       less_than_or_equal_to: 5,
                                       only_integer: true }
  validates :user_id, presence: true
end
