class SecretCode < ApplicationRecord
	resourcify	
	# make the user optional to allow nil values 
  belongs_to :user, optional: true
end
