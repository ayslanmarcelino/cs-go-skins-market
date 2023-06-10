module Charts
  module Transactions
    module Profit
      module ByMonth
        class Generate < ApplicationService
          def initialize(current_user:)
            @current_user = current_user
          end

          def call
            generate
          end

          private

          def generate
            @current_user.transactions
                         .finisheds
                         .joins(:transaction_type)
                         .group(date_trunc)
                         .select(
                           date_trunc.as("month"),
                           Arel.sql(
                             "SUM(transactions.value - COALESCE(skins.amount_paid, 0)) AS profit"
                           )
                         )
                         .left_joins(:skins)
                         .order(date_trunc)
                         .pluck(
                           date_trunc,
                           Arel.sql("SUM(transactions.value - COALESCE(skins.amount_paid, 0))")
                         )
          end

          def date_trunc
            Arel.sql("DATE_TRUNC('month', transactions.created_at)::date")
          end
        end
      end
    end
  end
end
