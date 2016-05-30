class OrdersController < ApplicationController

  def home
    
  end


def order_master_input
    @buyer_profiles = BuyerProfileTable.all
   # @lots = LotTable.all
   #@stylestm = StyleTable.all
 	#redirect_to home_productions_path 

end

  def add_order
  	StyleTable.create!(production_params) 



# render :action => 'style_master_input' 
   redirect_to order_master_input_orders_path 

  end


  
private 
   def production_params
     params.require(:orders).permit(:buyer_id, :lot_number,:lc_no)
  end 

end