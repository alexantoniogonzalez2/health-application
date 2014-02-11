class FiCertificados < ActiveRecord::Base
	
	belongs_to :atencion_salud, :class_name => 'FiAtencionesSalud'

  private
  def app_params
    params.require(:list).permit(:atencion_salud,
  								:fecha_final,
  								:fecha_inicio,
  								:id,
  								:motivo)
  end
								
end
