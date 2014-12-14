class RegistrationController < Devise::RegistrationsController
	def new
		@user= User.new
		@persona = PerPersonas.new
	end
	def create
		@user = User.new
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]
		@user.password_confirmation =params[:user][:password_confirmation]
		@persona = PerPersonas.new
		@persona.nombre = params[:persona][:nombre]
		@persona.apellido_paterno = params[:persona][:apellido_paterno]
		@user.valid?
		if @user.errors.blank?
			@user.save
			@persona.user = @user
			@persona.save
			redirect_to dashboard_path
		else
			render :action => "new"
		end
	end
end