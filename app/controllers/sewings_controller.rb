class SewingsController < ApplicationController

def sewing_search

  @buyer_profiles = BuyerProfileTable.all
  @lots = LotTable.all
  @styles = StyleTable.all
  @product_name = StyleTable.all

    buyer_id = production_params[:buyer_id]
    lot_id = production_params[:lot_id]
    style_no = production_params[:style_no]
    product_name = production_params[:product_name]
 
  unless buyer_id.nil? 
    style_id = StyleTable.where(:buyer_id => buyer_id , :lot_id => lot_id ,:style_no => style_no ,:product_name => product_name).limit(1).pluck(:style_id).first
    cookies[:buyer_id_master_cutting] = buyer_id 
    cookies[:lot_id_master_cutting] = lot_id 
    cookies[:style_id_master_cutting] = style_id 
  
  end
     

    #popuollating the  table for specific styledetails
  
    @posts = StyleTable.pick_some_data(style_id) # buyer_id parameter

    puts buyer_id.inspect
    puts lot_id.inspect
    puts style_no.inspect
    
    puts buyer_id.inspect
 
    puts product_name.inspect
    puts style_id.inspect
  

end

def sewing_show_one

  ck_a = cookies[:buyer_id_master_sewing] #buyer_id
  ck_b = cookies[:lot_id_master_sewing] #lot_id
  ck_c = cookies[:style_id_master_sewing] #style_id

   #get the order quantity for this particular style id
      orderq = StyleTable.select(:order_quantity).where(:style_id => ck_c)
      current_orderq = orderq[0].order_quantity
      ##############################################


  first_instance = SewingInputTable.new( :buyer_id => ck_a , :lot_id => ck_b, :style_id => ck_c ,:remaining_target => current_orderq)
  first_save = first_instance.save
  first_instance_id = first_instance.sewing_input_table_id

###############
  total_smv = 0
  total_manpower = 0
  
  a = params["course"]["track_codes"].length.to_i
    i = 0
      loop do
        
      current_process_name= params["course"]["track_codes"][i].to_s
      current_smv = params["course1"]["track_codes1"][i].to_s
      total_smv = params["course1"]["track_codes1"][i].to_f + total_smv
      current_target = 60/current_smv.to_f 
      current_target.round(2)
      #params["course2"]["track_codes2"][i].to_s
      current_machine_name = params["course3"]["track_codes3"][i].to_s
      current_attachment = params["course4"]["track_codes4"][i].to_s
      current_work_station = 150/current_target.to_f
      current_work_station.round(2)
      #params["course5"]["track_codes5"][i].to_s
      current_operator = params["course6"]["track_codes6"][i].to_s
      current_helper = params["course7"]["track_codes7"][i].to_s
      #total_operator = params["course6"]["track_codes6"][i].to_i + total_operator
      #puts current_operator.inspect
      total_manpower = params["course7"]["track_codes7"][i].to_i + params["course6"]["track_codes6"][i].to_i + total_manpower
      current_remark = params["course8"]["track_codes8"][i].to_s

      
      second_instance = SewingProcessDetailsTable.new( :process_name => current_process_name , :sewing_input_table_id =>  first_instance_id , :smv => current_smv , :target => current_target, :machine_name => current_machine_name, :attachment => current_attachment, :work_station => current_work_station, :operator => current_operator, :helper => current_helper , :remark => current_remark)
      second_save = second_instance.save
        i += 1
          if i >= a
            break       # this will cause execution to exit the loop
          end
        end



######################
      puts total_manpower.inspect
      puts total_smv.inspect
      ie_day_target = 600 * (total_manpower/total_smv).round(2)
      hourly_target = (ie_day_target/10).round(2)
      SewingInputTable.where('sewing_input_table_id LIKE ?', first_instance_id).update_all("manpower"  => total_manpower , "total_smv"  => total_smv , "ie_day_target"  => ie_day_target , "hourly_target"  => hourly_target)
      cookies[:ie_day_target_sewing] = ie_day_target 
      @posts =  SewingProcessDetailsTable.all.group("machine_name").select("COUNT(machine_name) AS cm,machine_name")
  


 #render :action => 'sewing_search' 
 #redirect_to sewing_search_sewings_path

  respond_to do |format|
    format.html # tablebill.html.erb 
end
end
def sewing_lineman

#@posts = CuttingInputTable.pick_some_data
#@posts = CuttingInputTable.all
#@posts = BuyerProfileTable.all

#@posts = SewingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = sewing_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = sewing_input_table.style_id').select("style_table.style_no,style_table.order_quantity,buyer_profile_table.buying_house_name,cutting_input_table.table_no,cutting_input_table.per_hour_target,cutting_input_table.remaining_output,cutting_input_table.per_day_target,cutting_input_table.last_day_output").where("cutting_input_table.complete_status" => "Not complete" ).to_a
@posts = SewingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = sewing_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = sewing_input_table.style_id').select("style_table.style_no,buyer_profile_table.buying_house_name,sewing_input_table.remaining_target,sewing_input_table.manpower,sewing_input_table.hourly_target,sewing_input_table.ie_day_target,sewing_input_table.remaining_target,sewing_input_table.last_day_output").where("sewing_input_table.complete_status" => "Not complete" ).to_a



  respond_to do |format|
    format.html # tablebill.html.erb
  end 

end



def sewing_show
 #params.require(:cuttings).permit(tb:[])
      #getting array length
      a = params["cuttingline"]["track_codes"].length.to_i
      #b = params["course"]["track_codes"][1].to_s
      #SewingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = sewing_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = sewing_input_table.style_id').select("style_table.style_no,buyer_profile_table.buying_house_name,sewing_input_table.remaining_target,sewing_input_table.manpower,sewing_input_table.hourly_target,sewing_input_table.ie_day_target,sewing_input_table.remaining_target").where("sewing_input_table.complete_status" => "Not complete" ).to_a
      user = SewingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = sewing_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = sewing_input_table.style_id').select("style_table.style_no,style_table.order_quantity,sewing_input_table.remaining_target,sewing_input_table.last_day_output,sewing_input_table.style_id,sewing_input_table.last_day_output,sewing_input_table.sewing_input_table_id").where("sewing_input_table.complete_status" => "Not complete" ).to_a

      #puts user[0].inspect
      #am = user[0].table_no
      #puts am
      ###############


      i = 0
        loop do
        current_Id = user[i].sewing_input_table_id
        c_style_id = user[i].style_id
        c_style_no = user[i].style_no
        #order_quantity = user[i].order_quantity
        prev_last_day_output = user[i].last_day_output
        current_remaining_output = user[i].remaining_target
        current_last_day_output = params["cuttingline"]["track_codes"][i].to_s
        new_remaining_output = current_remaining_output.to_i - current_last_day_output.to_i
        # puts "break"
        # puts current_Id
        #puts current_last_day_output
        #puts "break"

        #@posts = CuttingInputTable.pick_some_data_cut_line(current_Id,current_last_day_output)
        SewingInputTable.where('sewing_input_table_id LIKE ?', current_Id).update_all("last_day_output" => current_last_day_output , "remaining_target" => new_remaining_output)
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
    



      render :action => 'sewing_lineman' 
      #redirect_to sewing_lineman_sewings_path 
end





  def sewing_master_input
  	#StyleTable.create!(production_params) 
  	buyer_id = production_params[:buyer_id]
  	lot_id = production_params[:lot_id]
    @posts = StyleTable.pick_some_data(buyer_id,lot_id) # buyer_id parameter



  respond_to do |format|
    format.html # tablebill.html.erb
  end 
  end
#####################################
  def sewing_machine_input
 
   ck_c = cookies[:style_id_master_sewing] #style_id
   ck_ie = cookies[:ie_day_target_sewing] # ie_day_target
  # puts ck_ie.inspect
#params.require(:cuttings).permit(tb:[])
      #getting array length
      a = params["sewingmachine"]["track_codes"].length.to_i
     # puts a
      #b = params["course"]["track_codes"][1].to_s
      machinedet=SewingProcessDetailsTable.all.group("machine_name").select("COUNT(machine_name) AS cm,machine_name")


      #puts user[0].inspect
      #am = user[0].table_no
      #puts am
      ###############

      i = 0
        loop do
        current_machine = machinedet[i].machine_name
        current_machine_total = machinedet[i].cm
        current_wise_part_one = params["sewingmachine"]["track_codes"][i].to_s
        current_wise_part_two = params["sewingmachine1"]["track_codes1"][i].to_s
        current_wise_part_three = current_wise_part_two.to_f * ck_ie.to_f
     
        
       second_instance = SewingMachineProcessDetailsTable.new( :sewing_input_table_id => ck_c , :machine_name =>  current_machine , :total_machine => current_machine_total , :wise_target_part_one => current_wise_part_one, :wise_target_part_two => current_wise_part_two, :wise_target_part_three => current_wise_part_three)
       second_save = second_instance.save
        i += 1
          if i >= a
              break       # this will cause execution to exit the loop
          end



        end
      ###########

  respond_to do |format|
    format.html # tablebill.html.erb
  end 
  end
###################################
  def get_buyer_profile_lots
  	@lots = LotTable.where(buyer_id: params[:buyer_id])
  	lots = @lots.collect{|l| { lot_number: l.lot_number, lot_id: l.lot_id}}
  	render json: lots
  end

   # def get_buyer_profile_styles
    #@styles = StyleTable.where(lot_id: params[:lot_id])
   # styles = @styles.collect{|s| { style_no: s.style_no, style_id: s.style_id}}
    #render json: styles
 # end

  def get_buyer_profile_styles

    @styles = StyleTable.where(lot_id: params[:lot_id]).distinct.select("style_no")
    styles = @styles.collect{|s| { style_no: s.style_no, style_no: s.style_no}}
    render json: styles
  end

def get_buyer_profile_product_name

   
    
   # @orderq = StyleTable.where(color: params[:color]).select("order_quantity")
   @product_name = StyleTable.where(style_no: params[:style_no]).select("product_name")
    product_name = @product_name.collect{|p| { product_name: p.product_name, product_name: p.product_name}}
    render json: product_name



  end
private 
   def production_params
     #params.require(:sewings).permit(:buyer_id, :lot_id , :style_no ,:style_id)
       params.fetch(:sewings,{}).permit(:buyer_id, :lot_id , :style_no, :style_id, :product_name)
  end 

end