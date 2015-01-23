class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_one :persona, :class_name => 'PerPersonas'
  
  #attr_accessible :email, :password, :password_confirmation; :persona     
 	def app_params
    params.require(:user).permit(:email)
  end
  
         
end
