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
                         .select(date_trunc, profit)
                         .group(date_trunc)
                         .pluck(date_trunc, profit)
          end

          def date_trunc
            Arel.sql("DATE_TRUNC('month', transactions.created_at)::date")
          end

          def profit
            Arel.sql('SUM(transactions.value - transactions.amount_paid)')
          end
        end
      end
    end
  end
end
