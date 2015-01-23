class RegistrationController < Devise::RegistrationsController
	def new
		@user= User.new
		@persona = PerPersonas.new
	end
	def create
		@user = User.new
		@user.email = params[:user][:email]
		@user.password = params[:user][:password]
		@user.password_confirmation = params[:user][:password_confirmation]
		@persona = PerPersonas.new
		@persona.nombre = params[:nombre]
		@persona.apellido_paterno = params[:apellido_paterno]
		@persona.apellido_materno = params[:apellido_materno]
		@persona.rut = params[:rut]
		@persona.genero = params[:sexo] == 1 ? 'Masculino' : 'Femenino'
		@user.valid?
		if @user.errors.blank?
			@user.save
			@persona.user = @user
			@persona.save
			redirect_to account_created_path
		else
			render :action => "new"
		end
	end
	def sign_in		

	end
end