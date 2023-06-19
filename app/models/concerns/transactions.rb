module Transactions
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm do
      state :pending, initial: true
      state :canceled
      state :finished

      event :cancel, success: :remove_skin_transaction! do
        transitions from: :pending, to: :canceled
      end

      event :finish, if: :has_skin?, success: [:update_skins!, :update_transaction!] do
        transitions from: :pending, to: :finished
      end
    end
  end

  private

  def update_transaction!(transaction)
    transaction.update(amount_paid: skins.sum(:amount_paid))
  end

  def update_skins!(transaction)
    transaction.skins.update!(available: false)
  end

  def has_skin?
    skins.present?
  end

  def remove_skin_transaction!(skins)
    skins.update!(transaction_id: nil)
  end
end
