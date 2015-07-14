class PrePrestadoresTelefonos < ActiveRecord::Base

	belongs_to :telefono, :class_name => 'TraTelefonos'
	belongs_to :prestador, :class_name => 'PrePrestadores'

	private
  def app_params
    params.require(:list).permit(
    															:id,
    															:telefono,
    															:prestador)
  end

end
