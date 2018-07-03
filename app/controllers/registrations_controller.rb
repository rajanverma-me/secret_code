class RegistrationsController < Devise::RegistrationsController
	before_action :check_secret_code, only: :create
	after_action :associate_user, only: :create


	# List the unassociated available codes in registration form
	def new
		super
	end

	private

		def sign_up_params
			params.require(:user).permit(:first_name, :last_name, :secret_code, :email, :password)
		end


	protected
		# this will run before user creation and will check for secret code presence.  
		def check_secret_code
			@sc = SecretCode.find_by(secret_code: params[:secret_code])
			if @sc.nil? || params[:secret_code] == ""
				redirect_back fallback_location: "/", alert: "Please Provide Valid Secret Code"
			end
		end


		# this will run after creating user to associate the secret code selected key
		def associate_user
			# Check for persistence of user record just created
			secret_code = params[:secret_code]
			if resource.persisted?
				# Find the secret code by params ID
				# If code existed in DB, associate it
				@code = SecretCode.find_by(temp_user: params[:user][:email])
				if !@code.nil?
					@code.user = resource
					@code.temp_user = nil
 					@code.save
				else
					redirect_back fallback_location: "/", alert: "Wrong Code"
				end
			end
		end

end