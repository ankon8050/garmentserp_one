class FinishingInputTable < ActiveRecord::Base
	#has_secure_password
  self.table_name = "finishing_input_table"

#scope :pick_some_data, joins(:buyer_profile_table, :style_table).select("table_number, per_hour_target, buyer_profile_table.buying_house_name as bname, style_table.style_no as sno")



end


