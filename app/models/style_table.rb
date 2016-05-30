class StyleTable < ActiveRecord::Base
  self.table_name = "style_table"


#scope :pick_some_data,->(buyer_id,lot_id) {where('style_table.buyer_id = ? AND style_table.lot_id = ?', buyer_id,lot_id).select('style_no,color,order_quantity,style_id')}
scope :pick_some_data,->(style_id) {where(' style_table.style_id = ?', style_id).select('style_no,color,order_quantity,style_id')}
#scope :pick_some_data1,->(buyer_id,lot_id) {where('style_table.buyer_id = ? AND style_table.lot_id = ?', buyer_id,lot_id).select('style_no')}

scope :pick_some_data_one,->(search_styleno) {where('style_table.style_no = ?',search_styleno).select('style_id')}

#scope :pick_some_data_styleid,->(buyer_id,lot_id,style_no,color,order_quantity,product_name) {where('style_table.buyer_id = ? AND style_table.lot_id = ? AND style_table.style_no = ? AND style_table.color = ? AND style_table.order_quantity = ? AND style_table.product_name = ? AND style_table.complete_status ="Not complete"', buyer_id,lot_id,style_no,color,order_quantity,product_name).select('style_no,color,order_quantity,style_id,price')}



#scope :pick_some_data_styleidget,->(buyer_id,lot_id,style_no,product_name) {where('style_table.buyer_id = ? AND style_table.lot_id = ? AND style_table.style_no = ? AND  style_table.product_name = ? AND style_table.complete_status ="Not complete"', buyer_id,lot_id,style_no,product_name).select('style_no,color,order_quantity,style_id')}
end