class TraTelefonos < ActiveRecord::Base

	has_many :personas_telefonos, :class_name => 'PerPersonasTelefonos', :foreign_key => 'telefono_id'
	has_many :prestadores_telefonos, :class_name => 'PrePrestadoresTelefonos', :foreign_key => 'telefono_id'

	private
  def app_params
    params.require(:list).permit(	:id,
    															:codigo,
    															:numero,
    															:personas_telefonos,
    															:prestadores_telefonos)
  end
end
