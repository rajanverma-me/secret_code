class SecretCodeController < ApplicationController
  before_action :authenticate_admin, only: [:index, :generate_secret_code]
	
  def index
  	@secrets = SecretCode.all 		
  end

  def generate_secret_code
	  i = 1
		count = params[:count].to_i

		# Loop till the count provided
		until i > count do
		  @sc = SecretCode.new
			@secret = [*('a'..'z'),*('0'..'9')].shuffle[0,params[:length].to_i].join
			@sc.secret_code = @secret
			@sc.save
			i += 1
		end
		redirect_back fallback_location: "/", notice: "Generated"
  end

  def deliver_code
  	check = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i =~  params[:email]
  	if check.nil?
      render json: { data: nil, message: 'invalid', status: false  }
	    return
  	end
		@available_codes = SecretCode.where(user_id: nil, temp_user: nil)
    if SecretCode.all.empty?                   
      render json: { data: nil, message: "stack empty", status: false  }
    elsif @available_codes.empty?                 
      render json: { data: nil, message: 'not available', status: false  }
    else
    	SecretCodeMailer.email_code(params[:email], @available_codes.first.secret_code).deliver
 			sc = SecretCode.find(@available_codes.first.id)
      sc.temp_user = params[:email]
      ClearUserWorker.perform_in(30.minutes, sc.id)
      if sc.save!
      	render json: { data: nil, message: "success", status: true }
      end
    end
  end

  protected

		# Authenticate only admin to this controller actions
		def authenticate_admin
  		if user_signed_in? 
        if !(current_user.has_role? :admin) 
	  	    redirect_to "/", alert: "Unauthorized Access"
	  	    return
        end
      else
          redirect_to "/"
	  	    return
  		end
  	end
end
