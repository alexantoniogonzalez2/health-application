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
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		@agendamientos= AgAgendamientos.find(:all, :conditions => { :agendamiento_estado_id => [5,6], especialidad_prestador_profesional_id: @especialidad_prestador_profesional })
		
		return @agendamientos
	end

	def getProximosPacientes
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		@agendamientos= AgAgendamientos.find(:all, :conditions => { :agendamiento_estado_id => [1], especialidad_prestador_profesional_id: @especialidad_prestador_profesional })
		
		return @agendamientos
	end

	def getPacientesAtendidos
		@especialidad_prestador_profesional = PrePrestadorProfesionales.where("profesional_id = ? ",current_user.id).first
		@agendamientos= AgAgendamientos.find(:all, :conditions => { :agendamiento_estado_id => [7], especialidad_prestador_profesional_id: @especialidad_prestador_profesional })
		
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

	def getIdAtencion(agendamiento_id)
		atencion = FiAtencionesSalud.find_by agendamiento_id: agendamiento_id

		return atencion.id
		
	end

	def getDia
	
		return 55
		
	end


end
