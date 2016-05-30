class StylesController < ApplicationController

  def home
    
  end


def style_master_input
    @buyer_profiles = BuyerProfileTable.all
    @lots = LotTable.all
   #@stylestm = StyleTable.all
 	#redirect_to home_productions_path 

end

  def add_style
  	StyleTable.create!(production_params) 



# render :action => 'style_master_input' 
   redirect_to style_master_input_styles_path 

  end


  def get_buyer_profile_lots
  	@lots = LotTable.where(buyer_id: params[:buyer_id])
  	lots = @lots.collect{|l| { lot_number: l.lot_number, lot_id: l.lot_id}}
  	render json: lots
  end
private 
   def production_params
     params.require(:styles).permit(:buyer_id, :lot_id, :color,:order_no, :product_name, :order_quantity , :size, :total, :style_no )
  end 

end