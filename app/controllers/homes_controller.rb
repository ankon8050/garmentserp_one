class HomesController < ApplicationController

def admin

if params[:search].present?
	@posts = BuyerProfileTable.matching_contractNumber_or_contractDate(params[:search])
	#.page(params[:page])
  else
     @posts = BuyerProfileTable.all
   end
end

def search_status

	search_styleno = params[:style_no]
 	styleno = StyleTable.pick_some_data_one(search_styleno)

 	current_style_id = styleno[0].style_id
 	puts current_style_id.inspect

 	@postcutting = CuttingInputTable.joins('INNER JOIN buyer_profile_table ON buyer_profile_table.buyer_id = cutting_input_table.buyer_id INNER JOIN style_table ON style_table.style_id = cutting_input_table.style_id').select("style_table.style_no,style_table.order_quantity,buyer_profile_table.buying_house_name,cutting_input_table.table_no,cutting_input_table.per_hour_target,cutting_input_table.remaining_output,cutting_input_table.per_day_target,cutting_input_table.last_day_output").where("cutting_input_table.complete_status" => "Not complete" , "style_table.style_no" => params[:style_no]).to_a
  #CuttingInputTable.pick_some_data_cutting_search(current_style_id)
 	@postsewing = SewingInputTable.pick_some_data_sewing_search(current_style_id)

	 respond_to do |format|
    format.html # tablebill.html.erb
  end 

end	



#private 
   #def production_params
    # params.fetch(:homes,{}).permit(:search)
  #end 

end