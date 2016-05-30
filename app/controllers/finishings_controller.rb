class FinishingsController < ApplicationController

def finishing_search
    @buyer_profiles = BuyerProfileTable.all
    @lots = LotTable.all
    @styles = StyleTable.all
    @colors = StyleTable.all
    @order_quantity  = StyleTable.all
    @product_name = StyleTable.all

    buyer_id = production_params[:buyer_id]
    lot_id = production_params[:lot_id]
    style_no = production_params[:style_no]
    order_quantity = production_params[:order_quantity]
    color = production_params[:color]
    product_name = production_params[:product_name]
 
  unless buyer_id.nil? 
    style_id = StyleTable.where(:buyer_id => buyer_id , :lot_id => lot_id ,:style_no => style_no ,:product_name => product_name).limit(1).pluck(:style_id)
    cookies[:buyer_id_master_cutting] = buyer_id 
    cookies[:lot_id_master_cutting] = lot_id 
    cookies[:style_id_master_cutting] = style_id 
  
  end
     

    #popuollating the  table for specific styledetails
  
    @posts = StyleTable.pick_some_data(style_id) # buyer_id parameter

    puts buyer_id.inspect
    puts lot_id.inspect
    puts style_no.inspect
    puts order_quantity.inspect
    puts buyer_id.inspect
    puts color.inspect
    puts product_name.inspect
    puts style_id.inspect
  
    
   

end




def finishing_lineman

#@posts = CuttingInputTable.pick_some_data
#@posts = CuttingInputTable.all
#@posts = BuyerProfileTable.all

#@posts=CuttingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = cutting_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = cutting_input_table.style_id').select("style_table.style_no,buyer_profile_table.buying_house_name,cutting_input_table.table_no,cutting_input_table.per_hour_target").where("cutting_input_table.complete_status" => "Not complete" ).to_a
@posts = FinishingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = finishing_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = finishing_input_table.style_id').select("style_table.style_no,style_table.order_quantity,buyer_profile_table.buying_house_name,finishing_input_table.table_no,finishing_input_table.per_hour_target,finishing_input_table.remaining_output,finishing_input_table.per_day_target,finishing_input_table.last_day_output,finishing_input_table.process").where("finishing_input_table.complete_status" => "Not complete" ).to_a


  respond_to do |format|
    format.html # tablebill.html.erb
  end 

end

def finishing_show ###update lineman output

      #params.require(:cuttings).permit(tb:[])
      #getting array length
      a = params["cuttingline"]["track_codes"].length.to_i
      #b = params["course"]["track_codes"][1].to_s
      user = FinishingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = finishing_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = finishing_input_table.style_id').select("style_table.style_no,style_table.order_quantity,finishing_input_table.remaining_output,finishing_input_table.Id,finishing_input_table.last_day_output,finishing_input_table.style_id").where("finishing_input_table.complete_status" => "Not complete" ).to_a

      #puts user[0].inspect
      #am = user[0].table_no
      #puts am
      ###############


      i = 0
        loop do
        current_Id = user[i].Id
        c_style_id = user[i].style_id
        c_style_no = user[i].style_no
        #order_quantity = user[i].order_quantity
        prev_last_day_output = user[i].last_day_output
        current_remaining_output = user[i].remaining_output
        current_last_day_output = params["cuttingline"]["track_codes"][i].to_s
        new_remaining_output = current_remaining_output.to_i - current_last_day_output.to_i
        # puts "break"
        # puts current_Id
        #puts current_last_day_output
        #puts "break"

        #@posts = CuttingInputTable.pick_some_data_cut_line(current_Id,current_last_day_output)
        FinishingInputTable.where('Id LIKE ?', current_Id).update_all("last_day_output" => current_last_day_output , "remaining_output" => new_remaining_output)
        #puts params["course"]["track_codes"][i].to_s
       #check remiaing is 0?
       #checkremain = CuttingInputTable.select("remaining_output").where(:Id => current_Id)
       #check_remain = checkremain[i].remaining_output.to_i
       #if check_remain <= 0
         # CuttingInputTable.where('Id LIKE ?', current_Id).update_all("complete_status" => "Complete")
         # StyleTable.where('style_id LIKE ?', c_style_id).update_all("complete_status" => "Complete")
      # end
        
        i += 1
          if i >= a
              break       # this will cause execution to exit the loop
          end
        end
      ###########

      #puts a.inspect
      #puts d.inspect
      #puts b.inspect
      #respond_to do |format|
      #  format.html # tablebill.html.erb
      #end 
    



      #render :action => 'cutting_lineman' 
      #redirect_to cutting_lineman_cuttings_path 

end





################################################################################
def finishing_show_one      ###insert master output
    #StyleTable.create!(production_params) 
    #buyer_id = production_params[:buyer_id]
      #lot_id = production_params[:lot_id]
    #@posts = StyleTable.pick_some_data(buyer_id,lot_id) # buyer_id parameter

#render :action =>"cutting_master_input"


      ck_a = cookies[:buyer_id_master_cutting] #buyer_id
      ck_b = cookies[:lot_id_master_cutting] #lot_id
      ck_c = cookies[:style_id_master_cutting] #style_id
      puts ck_a.inspect
      puts ck_b.inspect
      puts ck_c.inspect

      #get the order quantity for this particular style id
      orderq = StyleTable.select(:order_quantity).where(:style_id => ck_c)
      current_orderq = orderq[0].order_quantity
      ##############################################


 ###############
      a = params["course"]["track_codes"].length.to_i
      i = 0
        loop do
        
        current_table_no = params["course"]["track_codes"][i].to_s
        current_working_hour = params["course1"]["track_codes1"][i].to_s
        current_hourly_output = params["course2"]["track_codes2"][i].to_s
        current_daily_target = params["course3"]["track_codes3"][i].to_s
         current_process = params["course4"]["track_codes4"][i].to_s
        per_day_target = current_hourly_output.to_f * current_working_hour.to_f
        first_instance = FinishingInputTable.new( :table_no => current_table_no , :working_hour =>  current_working_hour , :per_hour_target => current_hourly_output , :lot_id => ck_b, :buyer_id => ck_a, :style_id => ck_c , :per_day_target => per_day_target , :remaining_output => current_orderq, :process => current_process)
        first_save = first_instance.save
        i += 1
          if i >= a
              break       # this will cause execution to exit the loop
          end
        end
      ###########






     
 #redirect_to cutting_search_cuttings_path 
respond_to do |format|
  format.html # tablebill.html.erb
  end 
  end


############################

  def get_buyer_profile_lots
  	@lots = LotTable.where(buyer_id: params[:buyer_id])
  	lots = @lots.collect{|l| { lot_number: l.lot_number, lot_id: l.lot_id}}
  	render json: lots
  end

 # def custom_style
    # styles = StyleTable.where(lot_id: params[:lot_id], buyer_id: params[:buyer_id])
    # lots = styles.collect{|s| {lot_id: s.lot_id, lot_no: s.lot_no}}
    # render json: lots
 # end

  def get_buyer_profile_styles

    @styles = StyleTable.where(lot_id: params[:lot_id]).distinct.select("style_no")
    styles = @styles.collect{|s| { style_no: s.style_no, style_no: s.style_no}}
    render json: styles
  end
def get_buyer_profile_colors
    cookies[:style_no_master_cutting_temp] = params[:style_no]
    @colors = StyleTable.where(style_no: params[:style_no]).select("color")
    colors = @colors.collect{|c| { color: c.color, color: c.color}}
    render json: colors
end
  def get_buyer_profile_orderq
    ck_a = cookies[:style_no_master_cutting_temp] #buyer_id
    cookies[:color_master_cutting_temp] = params[:color]
   # @orderq = StyleTable.where(color: params[:color]).select("order_quantity")
   @order_quantity = StyleTable.where(:color => params[:color] , :style_no => ck_a).select("order_quantity")
    order_quantity = @order_quantity.collect{|o| { order_quantity: o.order_quantity, order_quantity: o.order_quantity}}
    render json: order_quantity

end

def get_buyer_profile_product_name

    ck_a = cookies[:style_no_master_cutting_temp] 
    ck_b = cookies[:color_master_cutting_temp] 
    cookies[:order_quantity_master_cutting_temp] = params[:order_quantity]
   # @orderq = StyleTable.where(color: params[:color]).select("order_quantity")
   @product_name = StyleTable.where(:order_quantity => params[:order_quantity] , :style_no => ck_a ,:color => ck_b).select("product_name")
    product_name = @product_name.collect{|p| { product_name: p.product_name, product_name: p.product_name}}
    render json: product_name



  end

  private 
   private 
  def production_params
     params.fetch(:finishings,{}).permit(:buyer_id, :lot_id , :style_no, :color,:order_quantity,:product_name)
  end 
  
  

end