class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true
  validates :sauna, presence: true,
                    numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 1,
                                    only_integer: true }
  validates :evaluate, presence: true,
                       numericality: { greater_than_or_equal_to: 1,
                                       less_than_or_equal_to: 5,
                                       only_integer: true }
  validates :user_id, presence: true

  scope :search, -> (search_params) do

    # search_paramsが空の場合以降の処理を行わない
    return if search_params.blank?

    name_like(search_params[:name])
    .address_like(search_params[:address])

  end

  scope :name_like, -> (name) {
    where('name LIKE ?', "%#{name}%") if name.present?
  }

  scope :address_like, -> (address) {
    where('address LIKE ?', "%#{address}%") if address.present?
  }

  # def Micropost.search(search_word)
  #   if search_word
  #     self.where(['name LIKE ?', "%#{search_word}%"])
  #   else
  #     self.all
  #   end
  # end
end
