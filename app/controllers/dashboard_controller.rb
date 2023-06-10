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
    @finished_transactions_by_month ||= Charts::Transactions::Profit::ByMonth::Generate.call(current_user: current_user)
  end
end
