# == Schema Information
#
# Table name: skin_consults
#
#  id               :bigint           not null, primary key
#  raw_data         :jsonb
#  steam_id_decimal :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Skin::Consult < ApplicationRecord
end
