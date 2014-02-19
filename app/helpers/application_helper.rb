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

	def getIdPrestador

		@prestador_administrativo = PrePrestadorAdministrativos.find_by administrativo_id: current_user.id
	
		return @prestador_administrativo.prestador_id

	end






end
