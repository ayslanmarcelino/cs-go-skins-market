module Transactions
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm do
      state :pending, initial: true
      state :canceled
      state :finished

      event :cancel do
        transitions from: :pending, to: :canceled
      end

      event :finish, if: :has_skin?, success: :update_skins! do
        transitions from: :pending, to: :finished
      end
    end
  end

  private

  def has_skin?
    skins.present?
  end

  def update_skins!(transaction)
    transaction.skins.update!(available: false)
  end
end
