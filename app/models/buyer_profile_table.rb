class BuyerProfileTable < ActiveRecord::Base
	#has_secure_password
  self.table_name = "buyer_profile_table"

#def self.matching_contractNumber_or_contractDate search
   #  where("contractNumber LIKE ? OR contractDate LIKE ?", "%#{search}%", "%#{search}%")
  #  where("buying_house_name LIKE ? ", "%#{search}%")
# end
 scope :by_query, ->(query) { where("buying_house_name like ? or buyer_contact_number like ?", "%#{query}%", "%#{query}%") }
end