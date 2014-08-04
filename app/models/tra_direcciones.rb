class TraDirecciones < ActiveRecord::Base

	has_many :prestadores_direcciones, :class_name => 'PrePrestadoresDirecciones', :foreign_key => 'direccion_id'
	has_many :personas_direcciones, :class_name => 'PerPersonasDirecciones', :foreign_key => 'direccion_id'
	belongs_to :comuna, :class_name => 'TraComunas'
	belongs_to :ciudad, :class_name => 'TraCiudades'
	belongs_to :pais, :class_name => 'TraPaises'


	private
  def app_params
    params.require(:list).permit(
    															:id, 
																	:calle,
																	:numero,
																	:departamento,
																	:comuna,
																	:ciudad,
																	:pais,
																	:prestadores_direcciones,
																	:personas_direcciones)
  end
  
end
