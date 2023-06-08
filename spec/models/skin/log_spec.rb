# == Schema Information
#
# Table name: skin_logs
#
#  id          :bigint           not null, primary key
#  steam_price :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  skin_id     :bigint
#
# Indexes
#
#  index_skin_logs_on_skin_id  (skin_id)
#
# Foreign Keys
#
#  fk_rails_...  (skin_id => skins.id)
#
require 'rails_helper'

RSpec.describe Skin::Log, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:skin) }
  end
end
