require 'rails_helper'

RSpec.describe Charts::Transactions::Profit::ByMonth::Generate, type: :service do
  describe '#call' do
    subject { described_class.new(current_user: current_user) }

    let!(:current_user) { create(:user) }
    let!(:transactions) { double('transactions') }
    let!(:joined_transactions) { double('joined_transactions') }
    let!(:grouped_transactions) { double('grouped_transactions') }
    let!(:selected_transactions) { double('selected_transactions') }
    let!(:ordered_transactions) { double('ordered_transactions') }
    let!(:plucked_transactions) { double('plucked_transactions') }

    it 'generates profit data by month' do
      expect(current_user).to receive(:transactions).and_return(transactions)
      expect(transactions).to receive(:finisheds).and_return(joined_transactions)
      expect(joined_transactions).to receive(:joins).with(:transaction_type).and_return(joined_transactions)
      expect(joined_transactions).to receive(:group).with(subject.send(:date_trunc)).and_return(grouped_transactions)
      expect(grouped_transactions).to receive(:select).with(subject.send(:date_trunc).as("month"), Arel.sql("SUM(transactions.value - COALESCE(skins.amount_paid, 0)) AS profit")).and_return(selected_transactions)
      expect(selected_transactions).to receive(:left_joins).with(:skins).and_return(selected_transactions)
      expect(selected_transactions).to receive(:order).with(subject.send(:date_trunc)).and_return(ordered_transactions)
      expect(ordered_transactions).to receive(:pluck).with(subject.send(:date_trunc), Arel.sql("SUM(transactions.value - COALESCE(skins.amount_paid, 0))")).and_return(plucked_transactions)

      result = subject.call

      expect(result).to eq(plucked_transactions)
    end
  end
end
