class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	# Create association
  has_one :secret_code

  before_destroy do
		sc = SecretCode.find(self.secret_code.id)
		sc.user = nil
		sc.save!
  end
end
