
class BuyersController < ApplicationController

def buyer_all

	
    @posts = BuyerProfileTable.all 



end

def buyer_create

#debug(params)
   # @posts = BuyerProfileTable.find(params[:buying_house_name])
	#if @posts.buyer_create[buyers_params]
		#BuyerProfileTable.create!(buyers_params) 
	first_instance = BuyerProfileTable.new( :buying_house_name => params[:buying_house_name] , :authorized_merchandizer_name =>  params[:authorized_merchandizer_name] , :authorizer_name => params[:authorizer_name] , :buyer_contact_number => params[:buyer_contact_number])
	first_save = first_instance.save
	 render :action => 'buyer_create'

	  
	#else
		#flash[:alert]="tasnim"
		#render 'buyer_create'
		#redirect_to buyer_create_buyers_path 
	#end

end

#private
# def buyers_params
   #params.require(:buyer).permit(:buying_house_name, :authorized_merchandizer_name, :authorizer_name, :buyer_contact_number)
  #end 



end