class FiInterconsultas < ActiveRecord::Base

	belongs_to :prestador_destino, :class_name => 'PrePrestadores'
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  private
  def app_params
    params.require(:list).permit(:atencion_salud,
  								:id,
  								:motivo.
  								:prestador_destino)
  end
								
end
