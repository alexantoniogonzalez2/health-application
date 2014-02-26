module ApplicationHelper

	def tieneRol(nombre_rol)

		@rol = PreRolAdministrativos.find_by nombre: nombre_rol
	
		@prestador_administrativo = PrePrestadorAdministrativos.find_by administrativo_id: current_user.id, rol_administrativo_id: @rol.id
	
		if @prestador_administrativo
			return true
		else
			return false
		end

	end

	def getIdPrestador(perfil)

		case perfil
		when 'administrativo'
			@prestador = PrePrestadorAdministrativos.find_by administrativo_id: current_user.id
		when 'profesional'	
			@prestador = PrePrestadorProfesionales.find_by profesional_id: current_user.id
		end 

		
	
		return @prestador.prestador_id

	end

	def esProfesionalSalud
	
		@prestador_profesional = PrePrestadorProfesionales.find_by profesional_id: current_user.id
	
		if @prestador_profesional
			return true
		else
			return false
		end

	end

	def getPacientesEnEspera
		 @agendamientos= AgAgendamientos.all
		 return @agendamientos
	end

end
