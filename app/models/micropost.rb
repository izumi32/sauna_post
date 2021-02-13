class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :sauna, presence: true
  validates :evaluate, presence: true
  validates :user_id, presence: true
  enum sauna: { absence: 0, presence: 1 }

  scope :search, -> (search_params) do

    # search_paramsが空の場合以降の処理を行わない
    return if search_params.blank?

    name_like(search_params[:name])
    .address_like(search_params[:address])
    .price_from(search_params[:price_from])
    .price_to(search_params[:price_to])
    .sauna_is(search_params[:sauna])
    .evaluate_is(search_params[:evaluate])
  end

  scope :name_like, -> (name) {
    where('name LIKE ?', "%#{name}%") if name.present?
  }

  scope :address_like, -> (address) {
    where('address LIKE ?', "%#{address}%") if address.present?
  }

  scope :price_from, -> (price_from) {
    where('? <= price', price_from) if price_from.present?
  }

  scope :price_to, -> (price_to) {
    where('price <= ?', price_to) if price_to.present?
  }

  scope :sauna_is, -> (sauna) {
    where(sauna: sauna) if sauna.present?
  }

  scope :evaluate_is, -> (evaluate) {
    where(evaluate: evaluate) if evaluate.present?
  }

end
