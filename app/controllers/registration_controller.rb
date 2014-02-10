class RegistrationController < Devise::RegistrationsController

def new

@user= User.new
#@contact = Contact.new
end

def create

@user = User.new
@user.email = params[:user][:email]
@user.password = params[:user][:password]
@user.password_confirmation =params[:user][:password_confirmation]

#@contact = Contact.new
#@contact.mobile = params[:contact][:mobile]
#@contact.address = params[:contact][:address]

@user.valid?
if @user.errors.blank?

@user.save
#@contact.user = @user
#@contact.save
redirect_to dashboard_path

else
render :action => "new"
end
end

end