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

      event :finish, if: :has_skin? do
        transitions from: :pending, to: :finished
      end
    end
  end

  private

  def has_skin?
    skins.present?
  end
end
