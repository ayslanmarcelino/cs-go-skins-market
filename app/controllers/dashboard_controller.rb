class DashboardController < ApplicationController
  before_action :finished_transactions_by_month, only: :index

  def index; end

  def pdf
    render(
      pdf: 'file',
      layout: 'application',
      template: 'dashboard/report'
    )
  end

  private

  def finished_transactions_by_month
    @finished_transactions_by_month ||= current_user.transactions
                                                    .finisheds
                                                    .joins(:transaction_type)
                                                    .group(month_trunc_sql)
                                                    .select(
                                                      month_trunc_sql.as("month"),
                                                      Arel.sql(
                                                        "SUM(transactions.value - COALESCE(skins.amount_paid, 0)) AS profit"
                                                      )
                                                    )
                                                    .left_joins(:skins)
                                                    .order(month_trunc_sql)
                                                    .pluck(
                                                      month_trunc_sql,
                                                      Arel.sql("SUM(transactions.value - COALESCE(skins.amount_paid, 0))")
                                                    )
  end

  def month_trunc_sql
    Arel.sql("DATE_TRUNC('month', transactions.created_at)::date")
  end
end
