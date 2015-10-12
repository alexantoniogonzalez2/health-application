module ApplicationHelper
	def devise_mapping
  	Devise.mappings[:user]
	end

	def resource_name
	  devise_mapping.name
	end

	def resource_class
	  devise_mapping.to
	end

	def getIdPrestador(perfil)

		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		case perfil
		when 'administrativo'
			@prestador = PrePrestadorAdministrativos.find_by administrativo_id: @usuario.id
		when 'profesional'	
			@prestador = PrePrestadorProfesionales.find_by profesional_id: @usuario.id
		end 		
	
		return @prestador.prestador_id

	end

	def tieneRol(nombre_rol)

		@rol = PreRolAdministrativos.find_by nombre: nombre_rol
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		@prestador_administrativo = PrePrestadorAdministrativos.find_by administrativo_id: @usuario.id, rol_administrativo_id: @rol.id
	
		if @prestador_administrativo
			return true
		else
			return false
		end

	end

	def esAdministrativo
		if tieneRol('Generar agendamientos') or tieneRol('Confirmar agendamientos') or tieneRol('Recibir pacientes') or tieneRol('Bloquear horas') or tieneRol('Generar estadísticas') or tieneRol('Tomar horas')
			return true
		else
			return false
		end
	end

	def esProfesionalSalud
	
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		@prestador_profesional = PrePrestadorProfesionales.find_by profesional_id: @usuario.id
	
		if @prestador_profesional
			return true
		else
			return false
		end
	end

	def getPacientesEnEspera
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@usuario.id).first
		@agendamientos= AgAgendamientos.find(:all, :conditions => { :estado_id => [5,6], especialidad_prestador_profesional_id: @especialidad_prestador_profesional })
		
		return @agendamientos
	end

	def getProximosPacientes
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@usuario.id).first
		@agendamientos= AgAgendamientos.find(:all, :conditions => { :estado_id => [1], especialidad_prestador_profesional_id: @especialidad_prestador_profesional })
		
		return @agendamientos
	end

	def getPacientesAtendidos
		@usuario = PerPersonas.where('user_id = ?',current_user.id).first
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",@usuario.id).first
		@agendamientos= AgAgendamientos.find(:all, :conditions => { :estado_id => [7], especialidad_prestador_profesional_id: @especialidad_prestador_profesional })
		
		return @agendamientos
	end

	def existeAtencion(agendamiento_id)
		atencion = FiAtencionesSalud.find_by agendamiento_id: agendamiento_id

		if (atencion) 		
			return true
		else 
			return false
		end		
	end

end
