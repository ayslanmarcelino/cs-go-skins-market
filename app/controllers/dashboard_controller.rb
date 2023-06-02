class DashboardController < ApplicationController
  def index; end

  def pdf
    render(
      pdf: 'file',
      layout: 'application',
      template: 'dashboard/report'
    )
  end
end
