class PersonaController < ApplicationController
	def agregarPersona

		@iniciador = params[:iniciador]
		@fam = Hash.new

		if params[:atencion_salud_id] == 'persona'
			@persona = PerPersonas.where('user_id = ?',current_user.id).first 
		else 
			@atencion_salud = FiAtencionesSalud.find(params[:atencion_salud_id])
			@persona = @atencion_salud.persona
		end

		if params[:correo] == ''
			next_id = User.maximum(:id) + 1
			correo = 'noreply'<<next_id.to_s<<'@medracer.com'
		else
			correo = params[:correo]	
		end	

		@user = User.new
		@user.email = correo
		@user.password = "Random123"
		respuesta = @user.save

		if respuesta
			@persona_nueva = PerPersonas.new
			@persona_nueva.nombre = params[:nombre]
			@persona_nueva.apellido_paterno = params[:apep]
			@persona_nueva.apellido_materno = params[:apem]
			@persona_nueva.rut = params[:rut]
			@persona_nueva.genero =  params[:sexo] == '1' ? 'Masculino' : 'Femenino'
			@persona_nueva.digito_verificador = params[:dv]
			@persona_nueva.fecha_nacimiento = params[:fecha_nacimiento]
			@persona_nueva.user = @user
			@persona_nueva.save!

			@telefono = TraTelefonos.new
			@telefono.codigo = params[:codigo] == 'Celular' ? '09' : '02'
			@telefono.numero = params[:celular]
			@telefono.save!
			
			@persona_telefono = PerPersonasTelefonos.new
			@persona_telefono.persona = @persona_nueva
			@persona_telefono.telefono = @telefono
			@persona_telefono.save!		

			@texto_relacion = ''
			case params[:relacion]
			when '1' #Padre
				@parentesco = PerParentescos.new
				@parentesco.hijo = @persona
				@parentesco.progenitor = @persona_nueva
				@parentesco.save!
				@texto_relacion = 'Padre'
			when '2' #Madre
				@parentesco = PerParentescos.new
				@parentesco.hijo = @persona
				@parentesco.progenitor = @persona_nueva 
				@gesta = FiGestas.new
				@gesta.persona = @persona_nueva
				@gesta.fecha_termino = @persona.fecha_nacimiento
				@gesta.fecha_inicio = @persona.fecha_nacimiento - 9.months
				@gesta.desenlace = "Parto normal"
				@gesta.save!
				@parentesco.gesta = @gesta
				@parentesco.save!
				@texto_relacion = 'Madre'
			when '3','4' #Hijo Hija
				@parentesco = PerParentescos.new
				@parentesco.hijo = @persona_nueva
				@parentesco.progenitor = @persona 
				if @persona.genero == 'Femenino'
					@gesta = FiGestas.new
					@gesta.persona = @persona
					@gesta.fecha_termino = @persona_nueva.fecha_nacimiento
					@gesta.fecha_inicio = @persona_nueva.fecha_nacimiento - 9.months
					@gesta.desenlace = "Parto normal"
					@gesta.save!
					@parentesco.gesta = @gesta
				end	
				@parentesco.save!
				@texto_relacion = params[:relacion] == '3' ? 'Hijo' : 'Hija'
			when '5' #Otro
				 @otra_relacion = PerOtrasRelaciones.new
				 @otra_relacion.persona = @persona
				 @otra_relacion.persona_relacion = @persona_nueva
				 @otra_relacion.relacion = params[:otro]
				 @otra_relacion.save!	
				 @texto_relacion = params[:otro]		
			end	
			@fam[@persona_nueva.id] = @texto_relacion	
		end 
				
		if respuesta	
			if @iniciador == 'fam' 
				respond_to do |format|
					format.js { }		
					format.json { }						
				end
			else	
				respond_to do |format|
					format.json { render :json => { :success => respuesta, :id => @persona_nueva.id, :text =>  @texto_relacion << ' - ' << @persona_nueva.showName('%n%p%m') }	}
					format.js { }				
				end
			end	
		else
			respond_to do |format|
				format.json { render :json => { :success => respuesta }	}
			end		
		end	
				
	end

end