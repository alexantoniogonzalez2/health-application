class PrePrestadores < ActiveRecord::Base

	has_many :prestador_profesionales, :class_name => 'PrePrestadorProfesionales', :foreign_key => 'prestador_id'
	has_many :prestador_administrativos, :class_name => 'PrePrestadorAdministrativos', :foreign_key => 'prestador_id'
	has_many :interconsultas, :class_name => 'FiInterconsultas', :foreign_key => 'prestador_destino_id'
	has_one :prestadores_direcciones, :class_name => 'PrePrestadoresDirecciones', :foreign_key => 'prestador_id'
	has_many :prestadores_telefonos, :class_name => 'PrePrestadoresTelefonos', :foreign_key => 'prestador_id'
	has_many :persona_prestaciones, :class_name => 'FiPersonaPrestaciones', :foreign_key => 'prestador_id'

	 def getDireccion
  	return prestadores_direcciones.direccion.calle + ' ' + prestadores_direcciones.direccion.numero.to_s + ', ' + prestadores_direcciones.direccion.comuna.nombre + ', ' + prestadores_direcciones.direccion.ciudad.nombre
  end 

	private
  def app_params
    params.require(:persona).permit(:id,:interconsultas,:nombre,:rut,:prestador_profesionales,:prestador_administrativos,:prestadores_direcciones,:prestadores_telefonos,:persona_prestaciones)
  end	


  						
end
