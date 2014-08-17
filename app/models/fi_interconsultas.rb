class FiInterconsultas < ActiveRecord::Base

	belongs_to :prestador_destino, :class_name => 'PrePrestadores'
	belongs_to :persona_diagnostico_atencion_salud, :class_name => 'FiPersonaDiagnosticosAtencionesSalud'
  belongs_to :especialidad, :class_name => 'ProEspecialidades' 

  private
  def app_params
    params.require(:list).permit(:id,:persona_diagnostico_atencion_salud,:fecha_solicitud,:prestador_destino,:especialidad,:proposito,:comentario)
  end
								
end
