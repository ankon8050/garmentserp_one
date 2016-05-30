class CuttingInputTable < ActiveRecord::Base
	#has_secure_password
  self.table_name = "cutting_input_table"

#scope :pick_some_data, joins(:buyer_profile_table, :style_table).select("table_number, per_hour_target, buyer_profile_table.buying_house_name as bname, style_table.style_no as sno")

#scope :pick_some_data_cut_line,->(current_Id,current_last_day_output){where('cutting_input_table.Id = ?', current_Id).update_all("last_day_output = ?",current_last_day_output)}
#scope :pick_some_data_cutting_search,->(current_style_id) {where('cutting_input_table .style_id = ?',current_style_id ).select("style_table.order_quantity,buyer_profile_table.buying_house_name,cutting_input_table.table_no,cutting_input_table.per_hour_target,cutting_input_table.remaining_output,cutting_input_table.per_day_target,cutting_input_table.last_day_output")}

end


