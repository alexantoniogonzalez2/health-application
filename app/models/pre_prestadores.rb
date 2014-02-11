class PrePrestadores < ActiveRecord::Base

	has_many :prestador_profesionales, :class_name => 'PrePrestadorProfesionales', :foreign_key => 'prestador_id'
	has_many :prestador_administrativos, :class_name => 'PrePrestadorAdministrativos', :foreign_key => 'prestador_id'
	has_many :interconsultas, :class_name => 'FiInterconsultas', :foreign_key => 'prestador_destino_id'

	private
  def app_params
    params.require(:persona).permit(:id, 
									:interconsultas,
									:nombre, 
									:rut,
									:prestador_profesionales,
									:prestador_administrativos)
  end		
  						
end
