# == Schema Information
#
# Table name: skin_consults
#
#  id               :bigint           not null, primary key
#  raw_data         :jsonb
#  source_cd        :string
#  steam_id_decimal :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
require 'rails_helper'

RSpec.describe Skin::Consult, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
