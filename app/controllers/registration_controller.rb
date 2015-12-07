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
		@persona.fecha_nacimiento = params[:date]
		@persona.rut = params[:rut]
		@persona.digito_verificador = params[:dv]
		@persona.genero = params[:sexo] == '1' ? 'Masculino' : 'Femenino'
		@user.valid?
		if @user.errors.blank?
			@user.save
			@persona.user = @user
			@persona.save
			unless params[:celular].blank?
				@celular = TraTelefonos.create! :codigo => 9, :numero => params[:celular]
				@persona_telefono = PerPersonasTelefonos.new
				@persona_telefono.persona = @persona
				@persona_telefono.telefono = @celular
				@persona_telefono.save!
			end	
			unless params[:fijo].blank?
				@fijo = TraTelefonos.create! :codigo => params[:codigo], :numero => params[:fijo]
				@persona_telefono = PerPersonasTelefonos.new
				@persona_telefono.persona = @persona
				@persona_telefono.telefono = @fijo
				@persona_telefono.save!
			end	
			redirect_to account_created_path
		else
			render :action => "new"
		end
	end
	
end