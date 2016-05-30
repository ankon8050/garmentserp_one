class SewingInputTable < ActiveRecord::Base
	#has_secure_password
  self.table_name = "sewing_input_table"

#scope :pick_some_data, joins(:buyer_profile_table, :style_table).select("table_number, per_hour_target, buyer_profile_table.buying_house_name as bname, style_table.style_no as sno")

scope :pick_some_data_sewing_search,->(current_style_id) {where('sewing_input_table.style_id = ?', current_style_id).select('ie_day_target,hourly_target,manpower,total_smv')}

end


